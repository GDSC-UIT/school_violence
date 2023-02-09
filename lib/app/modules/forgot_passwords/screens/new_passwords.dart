import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/email.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/input_label.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/new_password_dialog.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/text_field_confirm_password.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/text_field_new_password.dart';

class NewPassWordPage extends StatefulWidget {
  const NewPassWordPage({super.key});

  @override
  State<NewPassWordPage> createState() => _NewPassWordPageState();
}

class _NewPassWordPageState extends State<NewPassWordPage> {
  late TextEditingController _controller;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                SizedBox(height: 35),

                InkWell(
                  onTap: () {
                    Get.to(EmailPage());
                  },
                  child: Image.asset(
                    'assets/images/left-small.png',
                    width: 28,
                  ),
                ),
                SizedBox(height: 35),
                Row(
                  children: [
                    Text(
                      'Create new password ',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Montserrat',
                        color: AppColors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Image.asset(
                      'assets/images/lock.png',
                      width: 28,
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      'Save the new password in a safe place, if you \n forget it then you have to do a forgot \n password again.',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(103, 103, 103, 1),
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 49),
                InputLabel(text: 'Create a new password'),
                TextFieldNewPassword(),
                SizedBox(height: 37),
                InputLabel(text: 'Confirm new password'),
                TextFieldConfirmPassWord(),
                SizedBox(height: 29),
                Row(
                  children: [
                    Checkbox(
                      checkColor: AppColors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return AppColors.primaryColor;
                        }
                        return AppColors.primaryColor;
                      }),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          color: AppColors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NewPassWordDialog();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shadowColor: AppColors.primaryColorShadow,
                      elevation: 5,
                      minimumSize: const Size(382, 52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
