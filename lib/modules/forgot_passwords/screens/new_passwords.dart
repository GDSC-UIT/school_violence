import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../widgets/input_label.dart';
import '../widgets/new_password_dialog.dart';
import '../widgets/text_field_confirm_password.dart';
import '../widgets/text_field_new_password.dart';

class NewPassWordPage extends StatefulWidget {
  const NewPassWordPage({super.key});

  @override
  State<NewPassWordPage> createState() => _NewPassWordPageState();
}

class _NewPassWordPageState extends State<NewPassWordPage> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
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
                const SizedBox(height: 35),

                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                  padding: const EdgeInsets.only(right: double.infinity),
                ),
                const SizedBox(height: 35),
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
                const SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      'Save the new password in a safe place, if you \nforget it then you have to do a forgot \n password again.',
                      style: CustomTextStyle.desc(AppColors.desc),
                    ),
                  ],
                ),
                const SizedBox(height: 49),
                const InputLabel(text: 'Create a new password'),
                const TextFieldNewPassword(),
                const SizedBox(height: 37),
                const InputLabel(text: 'Confirm new password'),
                const TextFieldConfirmPassWord(),
                const SizedBox(height: 29),
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
                const SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const NewPassWordDialog();
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
