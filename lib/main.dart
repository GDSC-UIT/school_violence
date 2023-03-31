import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_violence_app/app/data/services/background_service.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/data/services/local-notification_service.dart';
import 'app/data/services/push-notification_service.dart';
import 'firebase_options.dart';

int? isViewed;
bool isLogged = false;
bool isEmergency = false;
late String deviceToken;
String? shootingCourt;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get user permission
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  // initialize background notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    isEmergency = true;
  }
  await initializeBackgroundService();

  //initialize firebase
  await Firebase.initializeApp(
    name: 'School Violence',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize push notification
  final messaging = FirebaseMessaging.instance;
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  deviceToken = (await messaging.getToken())!;

  if (kDebugMode) {
    log('Registration Token=$deviceToken');
  }
  if (kDebugMode) {
    log('Permission granted: ${settings.authorizationStatus}');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      log('Handling a foreground message: ${message.messageId}');
      log('Message notification: ${message.notification?.title}');
      log('Message notification: ${message.notification?.body}');
    }
    LocalNotificationService.ins.showNotification(message, isBackground: false);
    isEmergency = true;
    shootingCourt = message.notification?.body!
        .substring(message.notification!.body!.length - 1);
  });

  // auto login
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('intro');
  if (prefs.getString("email") != null) {
    UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: prefs.getString("email")!,
            password: prefs.getString("password")!);

    if (result.user != null) {
      isLogged = true;
      final signInCtrl = Get.put(SignInController());
      // update token
      FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .update({
        'token': deviceToken,
      });
      signInCtrl.updateUserId(result.user!.uid);
      getData(signInCtrl);
      Timer.periodic(
        const Duration(milliseconds: 100),
        (timer) {
          checkHelp(signInCtrl);
        },
      );
    }
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

void getData(SignInController signInCtrl) async {
  DocumentSnapshot snapUsers = await FirebaseFirestore.instance
      .collection('users')
      .doc(signInCtrl.userId.value)
      .get();

  if (snapUsers.data() != null) {
    signInCtrl.updateUserName((snapUsers.data()! as dynamic)['userName']);
    signInCtrl.updateEmail((snapUsers.data()! as dynamic)['email']);
    signInCtrl.updatePassword((snapUsers.data()! as dynamic)['password']);
    signInCtrl.updateFullName((snapUsers.data()! as dynamic)['fullName']);
    signInCtrl.updateDateOfBirth((snapUsers.data()! as dynamic)['dateOfBirth']);
    signInCtrl.updatePhoneNumber((snapUsers.data()! as dynamic)['phoneNumber']);
    signInCtrl.updateCountry((snapUsers.data()! as dynamic)['country']);
    signInCtrl.updateProvince((snapUsers.data()! as dynamic)['province']);
    signInCtrl.updateCity((snapUsers.data()! as dynamic)['city']);
    signInCtrl.updateSchool((snapUsers.data()! as dynamic)['school']);
    signInCtrl.updateExpert((snapUsers.data()! as dynamic)['expert']);
  }
}

void checkHelp(SignInController signInCtrl) async {
  DocumentSnapshot snapEmergency = await FirebaseFirestore.instance
      .collection('emergency')
      .doc(signInCtrl.userId.value)
      .get();
  if (snapEmergency.data() != null) {
    signInCtrl.updateFriendId((snapEmergency.data()! as dynamic)['friendId']);
  } else {
    signInCtrl.updateFriendId([]);
  }
}
