import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxInt selectedIndex = 1.obs;
  RxBool hide = true.obs;
  RxList province = [].obs;
  RxList city = [].obs;
  RxList school = [].obs;
  RxString userName = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString error = ''.obs;

  void updateSelectedIndex(int id) => selectedIndex.value = id;

  void updateHidePassword() => hide.value = !hide.value;

  void updateProvince(List data) => province.value = data;

  void updateCity(List data) => city.value = data;

  void updateSchool(List data) => school.value = data;

  void updateUserName(String data) => userName.value = data;

  void updateEmail(String data) => email.value = data;

  void updatePassword(String data) => password.value = data;

  void updateError(String data) => error.value = data;
}
