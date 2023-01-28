import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/intro/intro_controller.dart';
import 'package:school_violence_app/app/modules/intro/widgets/indicator.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  final IntroController ctrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          3,
          (index) => Obx(
            () => Indicator(
              isActive:
                  ctrl.selectedIndex.value == index ? true : false,
            ),
          ),
        ),
      ],
    );
  }
}