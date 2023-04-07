import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../sign_up_controller.dart';

class EmailField extends StatelessWidget {
  EmailField({
    Key? key,
    required emailController,
  })  : _emailController = emailController,
        super(key: key);

  final SignUpController ctrl = SignUpController();

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
      ),
      validator: (value) {
        bool isEmailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!);
        if (!isEmailValid) {
          return 'Invalid email.';
        }
        return null;
      },
      onChanged: (val) {
        // ctrl.updateEmail(val);
      },
    );
  }
}
