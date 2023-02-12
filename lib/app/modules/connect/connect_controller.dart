import 'package:get/get.dart';

class ConnectController extends GetxController {
  RxList searchResult = [].obs;
  RxString userId = ''.obs;
  RxBool isSent = false.obs;
  RxInt id = 0.obs;

  void updateSearchResult(List data) => searchResult.value = data;

  void updateUserId(String data) => userId.value = data;

  void updateIsSent(bool data) => isSent.value = data;

  void updateId(int data) => id.value = data;
}
