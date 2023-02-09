import 'package:get/get.dart';

class ConnectController extends GetxController {
  RxList searchResult = [].obs;
  RxString userId = ''.obs;

  void updateSearchResult(List data) => searchResult.value = data;

  void updateUserId(String data) => userId.value = data;
}
