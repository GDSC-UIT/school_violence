import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../../../routes/app_routes.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    Key? key,
  }) : super(key: key);

  _storeIntroInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('intro', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _storeIntroInfo();
        Get.toNamed(AppRoutes.signUp);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.primaryColorShadow,
        // elevation: 5,
        minimumSize: const Size(360, 50),
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
