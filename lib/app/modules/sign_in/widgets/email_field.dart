import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

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
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
      ),
      validator: (value) {
        bool _isEmailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!);
        if (!_isEmailValid) {
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
