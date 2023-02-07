import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
