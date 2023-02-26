import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class EmergencyDialog extends StatelessWidget {
  const EmergencyDialog({super.key});

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
                'Emergency notification',
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
                'Your friend need your help!!!',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Get.to(EmailPage());
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      shadowColor: AppColors.secondaryColorShadow,
                      elevation: 5,
                      minimumSize: const Size(128, 43),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: Text(
                      'No',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Get.to(EmailPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shadowColor: AppColors.primaryColorShadow,
                      elevation: 5,
                      minimumSize: const Size(128, 43),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: Text(
                      'Yes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
