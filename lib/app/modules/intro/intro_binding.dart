import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/intro/intro_controller.dart';

class IntroBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroController>(() => IntroController());
  }
}
