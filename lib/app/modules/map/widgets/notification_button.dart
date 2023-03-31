import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/map/widgets/map_dialog.dart';

import '../../../core/values/app_colors.dart';
import '../../../routes/app_routes.dart';

class notificationButton extends StatelessWidget {
  const notificationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 30, left: 8),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MapDialog();
              },
            );
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.white,
            child: Icon(
              Icons.notifications,
              color: AppColors.secondaryColorShadow,
            ),
          ),
        ),
      ),
    );
  }
}
