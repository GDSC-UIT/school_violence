import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school_violence_app/app/data/services/local-notification_service.dart';

import '../../../main.dart';

const apiKey =
    "AAAARaDbowA:APA91bH1e_XOTqKlvHwodmsEGZnJEKuaIlUaqIrmrhDtuTFqzBynMSxQWQNK4JTOJ62EueSZCRbr6Wg9yFRe7SSaGcFxJBs_qhBDZBB7xTB8WuFBtET76xsrxyGds59ZLtdPpAwk_jBS";

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    log("Handling a background message: ${message.messageId}");
    log('Message notification: ${message.notification?.title}');
    log('Message notification: ${message.notification?.body}');
  }
  LocalNotificationService.ins.showNotification(message);
}

Future<void> sendPushMessage({required String building}) async {
  List<String> tokens = List.filled(0, "", growable: true);

  await FirebaseFirestore.instance.collection('users').get().then((value) {
    for (var user in value.docs) {
      log(user.data()['token']);
      String token = user.data()['token'];
      if (token != "" && token != deviceToken) {
        tokens.add(token);
      }
    }
  });

  try {
    int count = 0;
    for (String token in tokens) {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$apiKey',
        },
        body: constructFCMPayload(token, building),
      );
      count++;
      log('FCM request for device sent $count!');
    }
  } catch (e) {
    log(e.toString());
  }
}

String constructFCMPayload(String? token, String building) {
  return jsonEncode({
    'to': token,
    'priority': 'high',
    'importance': 'max',
    'notification': {
      'title': 'Emergency Alert\n',
      'body': 'Shooting at building $building\n',
    },
  });
}
