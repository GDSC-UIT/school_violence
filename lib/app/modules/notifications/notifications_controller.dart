import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  RxList friendRequest = [].obs;
  RxString name = ''.obs;
  RxString school = ''.obs;
  RxString friendId = ''.obs;
  RxBool isFriend = false.obs;

  void updateFriendRequest(List data) => friendRequest.value = data;
  void updateName(String data) => name.value = data;
  void updateSchool(String data) => school.value = data;
  void updateFriendId(String data) => friendId.value = data;
  void updateIsFriend(bool data) => isFriend.value = data;
}
