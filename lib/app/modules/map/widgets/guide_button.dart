import 'package:flutter/material.dart';
import 'package:school_violence_app/app/modules/map/widgets/map_dialog.dart';

import '../../../core/values/app_colors.dart';

class GuideButton extends StatelessWidget {
  const GuideButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 8),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const MapDialog();
              },
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: AppColors.dontHaveAccount,
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.white,
              child: Icon(
                Icons.question_mark_sharp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
