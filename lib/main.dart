import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_violence_app/app/data/services/background_service.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

int? isViewed;
bool isLogged = false;
bool isEmergency = false;
String payload = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    isEmergency = true;
  }

  await initializeBackgroundService();

  await Firebase.initializeApp(
    name: 'School Violence',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
