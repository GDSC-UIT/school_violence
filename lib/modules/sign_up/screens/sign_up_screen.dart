import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../core/values/app_colors.dart';
import '../sign_up_controller.dart';
import '../widgets/back_button.dart';
import 'create_account_screen.dart';
import 'detailed_infor_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController ctrl = Get.find<SignUpController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 400,
              height: 40,
            ),
            Wrap(
              children: [
                BackButtonCustom(ctrl: ctrl),
                const SizedBox(width: 60),
                SizedBox(
                  height: 60,
                  width: 200,
                  child: Obx(
                    () => StepProgressIndicator(
                      totalSteps: 2,
                      currentStep: ctrl.selectedIndex.value,
                      size: 12,
                      padding: 0,
                      selectedColor: AppColors.primaryColor,
                      unselectedColor: AppColors.secondaryColor,
                      roundedEdges: const Radius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 683,
                  width: 400,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      ctrl.updateSelectedIndex(index + 1);
                    },
                    controller: PageController(viewportFraction: 1),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Obx(
                        (() => ctrl.selectedIndex.value - 1 == 0
                            ? createAccount()
                            : detailedInfor(context)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
