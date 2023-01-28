import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _test();
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
        'Continue with Apple',
        style: TextStyle(
          color: AppColors.black,
          fontSize: 16,
          fontFamily: 'Montserrat',
        ),
      ),
      icon: const FaIcon(
        FontAwesomeIcons.apple,
        color: AppColors.black,
      ),
    );
  }
}

void _test() {
  print('abc');
}
