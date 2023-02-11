import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/notifications/widgets/acceptedButton.dart';

class NameCard extends StatelessWidget {
  const NameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text(
          'Cao Minh Quân',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
            color: AppColors.black,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Le Quy Don High School for the Gifted',
          style: TextStyle(
            fontSize: 10,
            fontFamily: 'Montserrat',
            color: AppColors.blur,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: AcceptedButton(), // AcceptButton() để call thằng còn lại
      ),
    );
  }
}
