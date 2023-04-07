import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../sign_up_controller.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
    required this.ctrl,
    required formKey,
    required userNameController,
    required emailController,
    required passwordController,
  })  : _formKey = formKey,
        super(key: key);

  final SignUpController ctrl;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          //await _auth.signUp(userName, email, password);
          ctrl.updateSelectedIndex(2);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.primaryColorShadow,
        elevation: 5,
        minimumSize: const Size(300, 40),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      child: const Text(
        'Continue',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
