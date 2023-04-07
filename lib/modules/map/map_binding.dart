import 'package:get/get.dart';
import '../sign_in/sign_in_controller.dart';
import 'map_controller.dart';

class MapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(() => MapController());
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
