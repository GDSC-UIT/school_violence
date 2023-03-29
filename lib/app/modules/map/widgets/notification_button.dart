import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

class notificationButton extends StatelessWidget {
  const notificationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 30, left: 8),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.white,
          child: Icon(
            Icons.notifications,
            color: AppColors.secondaryColorShadow,
          ),
        ),
      ),
    );
  }
}
