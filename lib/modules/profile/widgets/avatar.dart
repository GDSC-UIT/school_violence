import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

class PersonalAvatar extends StatelessWidget {
  final String imageLink;
  const PersonalAvatar({
    super.key,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image.asset(
            imageLink,
            width: 90,
          ), // avatar
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.fromLTRB(60, 45, 0, 0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(120.0)),
                  color: AppColors.transparent),
              width: 25,
              child: const Icon(Icons.edit),
            ),
          )
        ],
      ),
    );
  }
}
