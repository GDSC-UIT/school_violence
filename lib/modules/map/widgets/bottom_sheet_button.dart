import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomRight,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.notification_important,
          color: AppColors.white,
        ),
      ),
    );
  }
}
