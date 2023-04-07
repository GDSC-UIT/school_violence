import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../sign_in_controller.dart';

class EmailField extends StatelessWidget {
  EmailField({
    Key? key,
    required emailController,
  })  : _emailController = emailController,
        super(key: key);

  final SignInController ctrl = SignInController();

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        prefixIcon: const Icon(
          Icons.email,
          color: AppColors.primaryColor,
        ),
        filled: true,
        hintText: "Email",
        hintStyle: const TextStyle(
          color: AppColors.dontHaveAccount,
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.transparent,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(30),
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
