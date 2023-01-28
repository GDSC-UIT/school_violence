import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        AuthServices().googleLogIn();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.grey,
        elevation: 5,
        minimumSize: const Size(300, 40),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      label: Text(
        'Continue with Google',
        style: TextStyle(
          color: AppColors.black,
          fontSize: 16,
          fontFamily: 'Montserrat',
        ),
      ),
      icon: const FaIcon(
        FontAwesomeIcons.google,
        color: Colors.red,
      ),
    );
  }
}

void _test() {
  print('abc');
}
