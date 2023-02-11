import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/notifications/widgets/acceptedButton.dart';
import 'package:school_violence_app/app/modules/profile/widgets/editProfileButton.dart';

class ProfileNameCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  const ProfileNameCard({
    super.key,
    required this.name,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
            color: AppColors.black,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          phoneNumber,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Montserrat',
            color: AppColors.blur,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: EditProfileButton(), // AcceptButton() để call thằng còn lại
      ),
    );
  }
}
