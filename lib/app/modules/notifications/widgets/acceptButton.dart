import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class AcceptButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 72,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
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
          'Accept',
        )),
        onPressed: () {},
      ),
    );
  }
}
