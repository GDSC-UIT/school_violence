import 'package:get/get.dart';

import '../connect/connect_controller.dart';
import '../sign_in/sign_in_controller.dart';
import 'diary_controller.dart';

class DiaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiaryController>(() => DiaryController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut(() => ConnectController());
  }
}
