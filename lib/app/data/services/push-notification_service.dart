import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school_violence_app/app/data/services/local-notification_service.dart';

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

Future<void> sendPushMessage({String court = 'A'}) async {
  List<String> tokens = [
    'fJe8dRAORLaLqbOwY2XNfl:APA91bHydFohGkiGCG6WD8q3TA5XLSuuStZOuwkebI06Av--pD3LHPAhM9NdN-HFmpYsgukiaOx7vOG_93_ko2TB5_6aSys3DQfxDC-zted7fXMaDozTH7bkSPNt570AmvFbxjmsb9q0',
    'euApEumQS1GTjfWyrrhE4X:APA91bEzvN9hYEuSK8laklRqz5DRATiVDOH5UvAAC-5cygEQxqEK8AyuB9_OMl-KMhu1ITiblPtdMdcKaLS97hAU5_KQgwFN4Ka6IbkTghU0WgizRgolENA9AMtqqeX62TtZR7-3rl9Z',
  ];

  try {
    int count = 0;
    for (String token in tokens) {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$apiKey',
        },
        body: constructFCMPayload(token, court),
      );
      count++;
      log('FCM request for device sent $count!');
    }
  } catch (e) {
    log(e.toString());
  }
}

String constructFCMPayload(String? token, String court) {
  return jsonEncode({
    'to': token,
    'priority': 'high',
    'importance': 'max',
    'notification': {
      'title': 'Emergency Alert\n',
      'body': 'Shooting at court $court\n',
    },
  });
}
