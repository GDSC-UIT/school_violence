import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';

class FullNameTextField extends StatelessWidget {
  const FullNameTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: AppColors.primaryColorShadow),
        ),
      ),
      child: TextFormField(
        style: CustomTextStyle.input(AppColors.black),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          // labelText: 'Enter your email',
        ),
        // validator: (val) => val!.isEmpty ? 'Enter an Full Name' : null,
        onChanged: (val) {
          //setState(() => userName = val);
        },
      ),
    );
  }
}
