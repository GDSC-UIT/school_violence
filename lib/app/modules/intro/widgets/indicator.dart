import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 22.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
          color: isActive == true
              ? AppColors.primaryColor
              : AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8.0)),
    );
  }
}