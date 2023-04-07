import 'package:get/get.dart';

import '../sign_in/sign_in_controller.dart';
import 'home_page_controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
