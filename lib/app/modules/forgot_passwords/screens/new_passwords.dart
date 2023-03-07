import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
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

                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30,
                  padding: EdgeInsets.only(right: double.infinity),
                ),
                SizedBox(height: 35),
                Row(
                  children: [
                    Text(
                      'Create new password ',
                      style: CustomTextStyle.h1(AppColors.black),
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
                      'Save the new password in a safe place, if you \nforget it then you have to do a forgot \n password again.',
                      style: CustomTextStyle.desc(AppColors.desc),
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
                        style: CustomTextStyle.desc(AppColors.black),
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
                      style: CustomTextStyle.button(AppColors.white),
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
