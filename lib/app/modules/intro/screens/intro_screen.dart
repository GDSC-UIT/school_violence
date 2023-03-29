import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/intro/intro_controller.dart';
import 'package:school_violence_app/app/modules/intro/widgets/get_started_button.dart';
import 'package:school_violence_app/app/modules/intro/widgets/have_account_button.dart';
import 'package:school_violence_app/app/modules/intro/widgets/onboarding_indicator.dart';
import 'package:school_violence_app/app/modules/intro/widgets/pictures_and_text.dart';

class IntroPage extends StatelessWidget {
  IntroPage({super.key});
  final IntroController ctrl = Get.find<IntroController>();

  final bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              width: 320,
              height: 180,
            ),
            picturesAndText(ctrl: ctrl),
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
    );
  }
}
