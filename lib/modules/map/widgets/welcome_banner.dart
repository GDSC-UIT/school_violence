import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../sign_in/sign_in_controller.dart';

class WelcomeBanner extends StatelessWidget {
  WelcomeBanner({super.key});

  final SignInController signInCtrl = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
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
        Expanded(
          child: Column(
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
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              )
            ],
          ),
        )
      ],
    );
  }
}
