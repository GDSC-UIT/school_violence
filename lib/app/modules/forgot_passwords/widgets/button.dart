import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/email.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.toScreen,
  }) : super(key: key);
  final String text;
  final Widget toScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.to(toScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shadowColor: AppColors.primaryColorShadow,
          elevation: 5,
          minimumSize: const Size(382, 52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: CustomTextStyle.button(AppColors.white),
        ),
      ),
    );
  }
}
