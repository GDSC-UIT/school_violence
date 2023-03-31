import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';

class FriendCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String avatarLink;
  const FriendCard(
      {super.key,
      required this.name,
      required this.phoneNumber,
      required this.avatarLink});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            avatarLink,
          ),
          minRadius: 30,
          maxRadius: 30,
        ),
        title: Text(
          name,
          style: CustomTextStyle.h2(AppColors.black),
        ),
        subtitle: Text(
          phoneNumber,
          style: CustomTextStyle.small_desc(AppColors.desc),
        ),
      ),
    );
  }
}
