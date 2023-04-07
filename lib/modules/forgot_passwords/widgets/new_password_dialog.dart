import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../../home_page/screens/home_page.dart';

class NewPassWordDialog extends StatelessWidget {
  const NewPassWordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 474),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 69),
              Image.asset(
                'assets/images/grey-square.png',
                width: 160,
              ),
              const SizedBox(height: 17),
              Text(
                'Welcome Back!',
                style: CustomTextStyle.h1(AppColors.primaryColor),
              ),
              const SizedBox(height: 16),
              Text(
                'You have successfully reset and \ncreate a new password.',
                style: CustomTextStyle.desc(AppColors.desc),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 59),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const HomePage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shadowColor: AppColors.primaryColorShadow,
                    elevation: 5,
                    minimumSize: const Size(382, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  child: Text(
                    'Go to Home',
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.button(AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
