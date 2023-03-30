import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const notificationChannelId = 'my_background';
const notificationId = 888;

class LocalNotificationService {
  static final LocalNotificationService ins =
      LocalNotificationService._internal();

  LocalNotificationService._internal() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void showNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notificationId,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            notificationChannelId,
            'shooting sos channel',
            icon: 'logo_protected',
            ongoing: true,
            priority: Priority.max,
          ),
        ),
      );
    }
  }

  void showBackgroundNotification() {
    flutterLocalNotificationsPlugin.show(
      notificationId,
      'School violence',
      'School shooting sos ready',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannelId,
          'shooting sos channel',
          icon: 'logo_protected',
          ongoing: true,
        ),
      ),
    );
  }
}
