import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class EditProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 106,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          primary: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          textStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
            color: AppColors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: (Text(
          'Edit Profile',
        )),
        onPressed: () {},
      ),
    );
  }
}
