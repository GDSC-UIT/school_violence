import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.dialog(
          Center(
            child: Container(
              alignment: Alignment.center,
              width: 341,
              height: 474,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 168,
                    height: 159,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                    ),
                  ),

                  //

                  SizedBox(height: 10),

                  //

                  Text(
                    'Successful!',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                    ),
                  ),

                  //

                  SizedBox(height: 10),

                  //

                  Text(
                    'Please wait  a moment, we are\npreparing for you...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),

                  //

                  SizedBox(height: 50),

                  //

                  Icon(
                    Icons.tiktok,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        );
      },
      child: Text(
        'Sign Up',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.primaryColorShadow,
        elevation: 5,
        minimumSize: const Size(300, 40),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
