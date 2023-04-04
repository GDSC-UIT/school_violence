import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

import '../../../core/values/app_colors.dart';

class WelcomeBanner extends StatelessWidget {
  WelcomeBanner({super.key});

  final SignInController signInCtrl = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/avatar.jpg'),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Hey, ",
                      style: TextStyle(color: AppColors.black, fontSize: 14),
                    ),
                    TextSpan(
                      text: signInCtrl.fullName.value,
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const Text(
                "Everything will be alright 🥰",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
