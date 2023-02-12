import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

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
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              color: AppColors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  color: AppColors.blur,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.circle,
                size: 6,
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
              color: AppColors.blur,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
