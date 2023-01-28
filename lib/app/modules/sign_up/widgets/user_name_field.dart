import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';

class UserNameField extends StatelessWidget {
  UserNameField({
    Key? key,
  }) : super(key: key);

  final SignUpController ctrl = SignUpController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.transparent, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
      ),
      validator: (val) => val!.isEmpty ? 'Enter an User Name' : null,
      onChanged: (val) {
        ctrl.updateUserName(val);
      },
    );
  }
}
