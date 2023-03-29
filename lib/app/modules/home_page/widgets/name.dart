import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/modules/home_page/widgets/bell.dart';

class Name extends StatelessWidget {
  const Name({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
              'Hi, Quan',
              style: CustomTextStyle.h1(AppColors.black),
            ),
          ],
        ),
        const Bell(),
      ],
    );
  }
}
