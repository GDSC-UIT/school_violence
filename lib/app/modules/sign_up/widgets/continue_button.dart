import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';

class ContinueButton extends StatelessWidget {
  ContinueButton({
    Key? key,
    required this.ctrl,
    required formKey,
  })  : _formKey = formKey,
        super(key: key);

  final AuthServices _auth = AuthServices();

  final SignUpController ctrl;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        ctrl.updateSelectedIndex(2);
        if (_formKey.currentState!.validate()) {
          dynamic result = await _auth.registerWithEmailAndPassword(
              ctrl.email.value, ctrl.password.value);
          if (result == null) {
            ctrl.updateError('Please supply a valid email');
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.primaryColorShadow,
        elevation: 5,
        minimumSize: const Size(300, 40),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
