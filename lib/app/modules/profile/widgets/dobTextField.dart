import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class DateOfBirthTextField extends StatelessWidget {
  const DateOfBirthTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: AppColors.primaryColorShadow),
        ),
      ),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Montserrat',
          color: AppColors.black,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          // labelText: 'Enter your email',
        ),
        // validator: (val) => val!.isEmpty ? 'Enter an Full Name' : null,
        onChanged: (val) {
          //setState(() => userName = val);
        },
      ),
    );
  }
}
