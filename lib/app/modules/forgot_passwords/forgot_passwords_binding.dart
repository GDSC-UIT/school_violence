import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/forgot_passwords_controller.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
