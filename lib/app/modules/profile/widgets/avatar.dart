import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

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
            '$imageLink',
            width: 90,
          ), // avatar
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.fromLTRB(60, 45, 0, 0),
              decoration: new BoxDecoration(
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(120.0)),
                  color: AppColors.transparent),
              width: 25,
              child: Icon(Icons.edit),
            ),
          )
        ],
      ),
    );
  }
}
