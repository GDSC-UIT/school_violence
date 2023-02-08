import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

class SignInButton extends StatelessWidget {
  SignInButton({
    Key? key,
    required formKey,
    required this.ctrl,
  })  : _formKey = formKey,
        super(key: key);

  final AuthServices _auth = AuthServices();
  final SignInController ctrl;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          dynamic result = await _auth.signInWithEmailAndPassword(
            ctrl.emailController.text,
            ctrl.passwordController.text,
          );
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
      child: Text(
        'Sign In',
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