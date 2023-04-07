import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../../sign_in/sign_in_controller.dart';
import 'bell.dart';

class Name extends StatelessWidget {
  Name({super.key});

  final SignInController signInCtrl = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo-protected.png',
                width: 50,
              ),
              const SizedBox(width: 16),
              Text(
                'Hi, ${signInCtrl.userName.value} ',
                style: CustomTextStyle.h1(AppColors.black),
              ),
            ],
          ),
          const Bell(),
        ],
      ),
    );
  }
}
