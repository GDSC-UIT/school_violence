import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';

class CustomReportCard extends StatelessWidget {
  const CustomReportCard({
    super.key,
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
          const SizedBox(height: 7),
          Row(
            children: [
              Text(
                subtitle,
                style: CustomTextStyle.desc(AppColors.desc),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.circle,
                size: 4,
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: CustomTextStyle.smallDesc(AppColors.desc),
          ),
        ],
      ),
    );
  }
}
