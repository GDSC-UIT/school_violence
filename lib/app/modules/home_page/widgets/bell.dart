import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class Bell extends StatelessWidget {
  const Bell({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.notifications);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bell.jpg',
              width: 28,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.notificationBackgroundColor),
              child: (Text(
                '1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Montserrat',
                  color: AppColors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
