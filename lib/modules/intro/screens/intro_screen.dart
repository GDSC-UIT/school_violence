import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../intro_controller.dart';
import '../widgets/get_started_button.dart';
import '../widgets/have_account_button.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/pictures_and_text.dart';

class IntroPage extends StatelessWidget {
  IntroPage({super.key});
  final IntroController ctrl = Get.find<IntroController>();

  final bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                width: 320,
                height: 180,
              ),
              PicturesAndText(ctrl: ctrl),
              const SizedBox(
                width: 320,
                height: 30,
              ),
              OnboardingIndicator(ctrl: ctrl),
              const SizedBox(
                width: 320,
                height: 30,
              ),
              const Divider(
                color: AppColors.grey,
                thickness: 1.5,
              ),
              const SizedBox(
                width: 320,
                height: 20,
              ),
              const GetStartedButton(),
              const SizedBox(
                width: 320,
                height: 20,
              ),
              const HaveAccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}
