import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/sign_up/screens/create_account_screen.dart';
import 'package:school_violence_app/app/modules/sign_up/screens/detailed_infor_screen.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';
import 'package:school_violence_app/app/modules/sign_up/widgets/back_button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final SignUpController ctrl = Get.find<SignUpController>();

  PageController pctrl = PageController();

  @override
  Widget build(BuildContext context) {
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
                SizedBox(width: 60),
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
                      roundedEdges: Radius.circular(10),
                    ),
                  ),
                ),
                Container(
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
                      return Container(
                        child: Obx(
                          (() => ctrl.selectedIndex.value - 1 == 0
                              ? createAccount()
                              : detailedInfor(context)),
                        ),
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
