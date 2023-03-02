import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.ctrl,
    required passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final SignUpController ctrl;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => TextFormField(
          controller: _passwordController,
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                ctrl.updateHidePassword();
              },
              icon: Icon(
                Icons.remove_red_eye,
                size: 20,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
            ),
          ),
          obscureText: ctrl.hide.value,
          validator: (value) {
            if (value.toString().length < 6) {
              return 'Password should be longer or equal to 6 characters.';
            }
            return null;
          },
          onChanged: (val) {
            // ctrl.updatePassword(val);
          },
        ),
      ),
    );
  }
}
