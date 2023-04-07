import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import 'edit_profile_button.dart';

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
            style: CustomTextStyle.smallDesc(AppColors.desc),
          ),
          trailing: const EditProfileButton()),
    );
  }
}
