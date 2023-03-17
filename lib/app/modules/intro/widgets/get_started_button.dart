import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.toNamed(AppRoutes.sign_up),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.primaryColorShadow,
        elevation: 5,
        minimumSize: const Size(300, 50),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      child: Text(
        'GET STARTED',
        style: CustomTextStyle.button(AppColors.white),
      ),
    );
  }
}
