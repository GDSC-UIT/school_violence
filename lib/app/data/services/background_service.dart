import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/data/services/local-notification_service.dart';

import '../../routes/app_routes.dart';

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();
  final flutterLocalNotificationsPlugin =
      LocalNotificationService.ins.flutterLocalNotificationsPlugin;

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'MY FOREGROUND SERVICE',
    importance: Importance.low,
  );

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("logo_protected"),
    ),
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    onDidReceiveNotificationResponse: (details) {
      log("alo alo: ${details.payload}");
      Get.toNamed(AppRoutes.map);
    },
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        notificationChannelId: notificationChannelId,
        initialNotificationTitle: 'School violence',
        initialNotificationContent: 'School shooting sos ready',
        foregroundServiceNotificationId: notificationId,
      ));
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        LocalNotificationService.ins.showBackgroundNotification();
      }
    }
    log("background service is running");
    service.invoke('update');
  });
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  log('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    log('notification action tapped with input: ${notificationResponse.input}');
  }
  Get.toNamed(AppRoutes.map);
}
