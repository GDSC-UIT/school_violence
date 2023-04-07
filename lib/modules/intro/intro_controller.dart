import 'package:get/get.dart';

class IntroController extends GetxController {
  RxInt selectedIndex = 0.obs;
  void updateSelectedIndex(int id) {
    selectedIndex.value = id;
  }
}
