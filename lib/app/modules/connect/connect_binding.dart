import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';

class ConnectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectController>(() => ConnectController());
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}
