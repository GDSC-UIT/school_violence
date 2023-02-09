import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class NewPassWordDialog extends StatelessWidget {
  const NewPassWordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: Container(
        constraints: BoxConstraints(maxHeight: 474),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 69),
              Image.asset(
                'assets/images/grey-square.png',
                width: 160,
              ),
              SizedBox(height: 17),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Montserrat',
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'You have successfully reset and \ncreate a new password.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  color: AppColors.black,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 59),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Get.to(EmailPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shadowColor: AppColors.primaryColorShadow,
                    elevation: 5,
                    minimumSize: const Size(382, 52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  child: Text(
                    'Go to Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
