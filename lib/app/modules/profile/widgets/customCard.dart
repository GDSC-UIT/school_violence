import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';

class CustomReportCard extends StatelessWidget {
  const CustomReportCard({
    required this.title,
    required this.subtitle,
    required this.text,
  });

  final String title;
  final String subtitle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 0.0, 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: CustomTextStyle.h2(AppColors.black),
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Text(
                subtitle,
                style: CustomTextStyle.desc(AppColors.desc),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.circle,
                size: 4,
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: CustomTextStyle.small_desc(AppColors.desc),
          ),
        ],
      ),
    );
  }
}
