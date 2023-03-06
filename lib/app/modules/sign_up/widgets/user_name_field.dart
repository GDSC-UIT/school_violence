import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';

class UserNameField extends StatelessWidget {
  UserNameField({
    Key? key,
    required userNameController,
  })  : _userNameController = userNameController,
        super(key: key);

  final SignUpController ctrl = SignUpController();

  final TextEditingController _userNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userNameController,
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
        if (value.toString().length <= 2) {
          return 'Enter valid user name.';
        }
        return null;
      },
      onChanged: (val) {
        // ctrl.updateUserName(val);
      },
    );
  }
}
