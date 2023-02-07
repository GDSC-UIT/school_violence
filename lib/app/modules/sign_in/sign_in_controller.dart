import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool hide = true.obs;
  RxBool remember = false.obs;

  void updateEmailController(TextEditingController data) =>
      emailController = data;

  void updatePasswordController(TextEditingController data) =>
      passwordController = data;

  void updateHidePassword() => hide.value = !hide.value;

  void updateRemember() => remember.value = !remember.value;
}
