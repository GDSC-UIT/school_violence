import 'package:get/get.dart';

class ConnectController extends GetxController {
  RxList searchResult = [].obs;
  RxBool sent = false.obs;

  void updateSearchResult(List data) => searchResult.value = data;

  void updateSent() => sent.value = !sent.value;
}
