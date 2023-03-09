import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/home_page/home_page_controller.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
