import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxInt selectedIndex = 1.obs;
  RxBool hide = true.obs;
  RxList province = [].obs;
  RxList city = [].obs;
  RxList school = [].obs;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String countryName = '';
  String provinceName = '';
  String cityName = '';
  String schoolName = '';

  void updateSelectedIndex(int id) => selectedIndex.value = id;

  void updateHidePassword() => hide.value = !hide.value;

  void updateProvince(List data) => province.value = data;

  void updateCity(List data) => city.value = data;

  void updateSchool(List data) => school.value = data;

  void updateUserNameController(TextEditingController data) =>
      userNameController = data;

  void updateEmailController(TextEditingController data) =>
      emailController = data;

  void updatePasswordController(TextEditingController data) =>
      passwordController = data;

  void updateCountryName(String data) => countryName = data;

  void updateProvinceName(String data) => provinceName = data;

  void updateCityName(String data) => cityName = data;

  void updateSchoolName(String data) => schoolName = data;
}
