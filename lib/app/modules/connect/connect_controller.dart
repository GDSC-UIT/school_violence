import 'package:get/get.dart';

class ConnectController extends GetxController {
  RxList searchResult = [].obs;
  RxBool isSent = false.obs;

  void updateSearchResult(List data) => searchResult.value = data;

  void updateIsSent(bool data) => isSent.value = data;
}
