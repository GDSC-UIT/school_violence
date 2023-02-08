import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class AcceptedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      width: 108,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor:
              AppColors.primaryColor, //change background color of button
          backgroundColor: AppColors.white, //change text color of button
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          textStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
            color: AppColors.black,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: (Text(
          'Accepted ✓',
        )),
        onPressed: () {},
      ),
    );
  }
}
