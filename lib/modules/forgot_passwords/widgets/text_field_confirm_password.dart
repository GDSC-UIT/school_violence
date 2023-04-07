import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

class TextFieldConfirmPassWord extends StatelessWidget {
  const TextFieldConfirmPassWord({super.key});

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
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Montserrat',
          color: AppColors.black,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          // labelText: 'Enter your email',
        ),
        validator: (val) => val!.isEmpty ? 'Enter an Full Name' : null,
        onChanged: (val) {
          //setState(() => userName = val);
        },
      ),
    );
  }
}
