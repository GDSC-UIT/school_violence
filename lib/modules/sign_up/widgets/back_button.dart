import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../sign_up_controller.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  final SignUpController ctrl;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ctrl.selectedIndex.value == 1
            ? Get.toNamed(AppRoutes.intro)
            : Get.toNamed(AppRoutes.signUp);
        ctrl.updateSelectedIndex(1);
      },
      icon: const Icon(
        Icons.arrow_back,
        size: 30,
        color: AppColors.black,
      ),
    );
  }
}
