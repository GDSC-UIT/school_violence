import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/modules/home_page/widgets/bell.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

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
