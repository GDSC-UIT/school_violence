import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'Montserrat',
        color: AppColors.black,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
