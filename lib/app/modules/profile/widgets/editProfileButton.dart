import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 106,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          textStyle: CustomTextStyle.button(AppColors.white),
        ),
        child: (const Text(
          'Edit Profile',
        )),
        onPressed: () {
          Get.toNamed(AppRoutes.info);
        },
      ),
    );
  }
}
