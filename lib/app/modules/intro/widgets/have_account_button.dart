import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class HaveAccountButton extends StatelessWidget {
  const HaveAccountButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _test();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        shadowColor: AppColors.secondaryColorShadow,
        elevation: 5,
        minimumSize: const Size(300, 40),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      child: const Text(
        'I ALREADY HAVE AN ACCOUNT',
        style: TextStyle(color: AppColors.primaryColor, fontSize: 15),
      ),
    );
  }
}

void _test() {
  print('abc');
}
