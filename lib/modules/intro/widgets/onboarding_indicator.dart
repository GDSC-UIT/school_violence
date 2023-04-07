import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../intro_controller.dart';
import 'indicator.dart';

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
              isActive: ctrl.selectedIndex.value == index ? true : false,
            ),
          ),
        ),
      ],
    );
  }
}
