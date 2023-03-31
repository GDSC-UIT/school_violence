import 'package:get/get.dart';

class DiaryController extends GetxController {
  RxList messages = [ ].obs;
  RxString userId = ''.obs;
  RxBool haveText = false.obs;
  RxBool isFetchingExpert = false.obs;
  void updateMessages(var mess){
    messages.value=mess;
  }
}
