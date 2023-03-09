import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool hide = true.obs;
  RxBool remember = false.obs;
  RxString userId = ''.obs;
  RxString userName = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString fullName = ''.obs;
  RxString dateOfBirth = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString country = ''.obs;
  RxString province = ''.obs;
  RxString city = ''.obs;
  RxString school = ''.obs;
  RxBool expert = false.obs;
  RxList friendId = [].obs;

  void updateUserId(String data) => userId.value = data;

  void updateUserName(String data) => userName.value = data;

  void updateEmail(String data) => email.value = data;

  void updatePassword(String data) => password.value = data;

  void updateFullName(String data) => fullName.value = data;

  void updateDateOfBirth(String data) => dateOfBirth.value = data;

  void updatePhoneNumber(String data) => phoneNumber.value = data;

  void updateCountry(String data) => country.value = data;

  void updateProvince(String data) => province.value = data;

  void updateCity(String data) => city.value = data;

  void updateSchool(String data) => school.value = data;

  void updateExpert(bool data) => expert.value = data;

  void updateEmailController(TextEditingController data) =>
      emailController = data;

  void updatePasswordController(TextEditingController data) =>
      passwordController = data;

  void updateHidePassword() => hide.value = !hide.value;

  void updateRemember() => remember.value = !remember.value;

  void updateFriendId(List data) => friendId.value = data;
}
