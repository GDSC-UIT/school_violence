import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';

class NotificationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}
