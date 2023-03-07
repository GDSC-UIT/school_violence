import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

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
      ),
    );
  }
}
