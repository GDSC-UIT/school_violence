import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';

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
      style: CustomTextStyle.label(AppColors.black),
    );
  }
}
