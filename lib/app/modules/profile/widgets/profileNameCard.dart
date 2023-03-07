import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
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
          leading: Image.asset(
            'assets/images/avatar.jpg', // Avatar
            width: 48,
          ), //
          title: Text(
            name,
            style: CustomTextStyle.desc(AppColors.black),
          ),
          subtitle: Text(
            phoneNumber,
            style: CustomTextStyle.small_desc(AppColors.desc),
          ),
          trailing: EditProfileButton()),
    );
  }
}
