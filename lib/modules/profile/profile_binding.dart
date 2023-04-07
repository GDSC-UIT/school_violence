import 'package:get/get.dart';
import 'package:school_violence_app/modules/profile/profile_controller.dart';

import '../sign_in/sign_in_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
