import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../sign_in_controller.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.ctrl,
    required passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final SignInController ctrl;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: _passwordController,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              ctrl.updateHidePassword();
            },
            icon: const Icon(
              Icons.remove_red_eye,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
          prefixIcon: const Icon(
            Icons.key,
            color: AppColors.primaryColor,
          ),
          filled: true,
          hintText: "Password",
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
        obscureText: ctrl.hide.value,
        validator: (value) {
          if (value.toString().length < 6) {
            return 'Password should be longer or equal to 6 characters.';
          }
          return null;
        },
        onChanged: (val) {
          // ctrl.updatePassword(val);
        },
      ),
    );
  }
}
