import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../../../routes/app_routes.dart';

class EmergencyDialog extends StatelessWidget {
  const EmergencyDialog({super.key});

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
                'Emergency notification',
                style: CustomTextStyle.h1(AppColors.primaryColor),
              ),
              const SizedBox(height: 16),
              Text(
                'Your friend need your help!!!',
                style: CustomTextStyle.desc(AppColors.desc),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 59),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Get.to(EmailPage());
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      shadowColor: AppColors.secondaryColorShadow,
                      elevation: 5,
                      minimumSize: const Size(128, 43),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: Text(
                      'No',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.button(AppColors.primaryColor),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.map);
                      // Get.to(EmailPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shadowColor: AppColors.primaryColorShadow,
                      elevation: 5,
                      minimumSize: const Size(128, 43),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: Text(
                      'Yes',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.desc(AppColors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
