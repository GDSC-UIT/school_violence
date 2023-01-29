import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';

class ContinueButton extends StatelessWidget {
  ContinueButton({
    Key? key,
    required this.ctrl,
    required formKey,
    required userNameController,
    required emailController,
    required passwordController,
  })  : _formKey = formKey,
        _userNameController = userNameController,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final AuthServices _auth = AuthServices();

  final SignUpController ctrl;

  final GlobalKey<FormState> _formKey;

  final TextEditingController _userNameController;

  final TextEditingController _emailController;

  final TextEditingController _passwordController;
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
      child: Text(
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
