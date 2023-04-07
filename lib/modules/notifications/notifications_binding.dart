import 'package:get/get.dart';

import '../connect/connect_controller.dart';
import 'notifications_controller.dart';

class NotificationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(() => NotificationsController());
    Get.lazyPut<ConnectController>(() => ConnectController());
  }
}
