import 'package:get/get.dart';

import '../notifications/notifications_controller.dart';
import '../sign_in/sign_in_controller.dart';
import 'connect_controller.dart';

class ConnectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectController>(() => ConnectController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}
