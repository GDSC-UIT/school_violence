import 'package:get/get.dart';

class MapController extends GetxController {
  RxInt selectedIndex = 0.obs;
  void updateSelectedIndex(int id) {
    selectedIndex.value = id;
  }
}
