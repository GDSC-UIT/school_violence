import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school_violence_app/app/data/services/local-notification_service.dart';

const api_key =
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

Future<void> sendPushMessage() async {
  String token =
      'f6REY4q0QGeKB52Ne0YtGk:APA91bF2XF0kWfshTvo4_VniC-wBvlSsVg0MvAykl9VH4V4nBAwWjr2lt6fHGfqhs-6bgCtMTqzlPlB5fQUbqLerRCR4RqSPeNdVChSBrVMl2RNnRNm4Wp83aYcJi6KJdA0ygKT-jOhl';

  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$api_key',
      },
      body: constructFCMPayload(token),
    );
    log('FCM request for device sent!');
  } catch (e) {
    log(e.toString());
  }
}

String constructFCMPayload(String? token) {
  return jsonEncode({
    'to': token,
    'priority': 'high',
    'notification': {
      'title': 'Emergency Alert',
      'body': 'Shooting at court A',
    },
  });
}
