import 'dart:async';

import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/global_widgets/help_dialog.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/button.dart';
import 'package:school_violence_app/app/modules/profile/screens/profile.dart';
import 'package:school_violence_app/app/modules/profile/widgets/EmailTextField.dart';
import 'package:school_violence_app/app/modules/profile/widgets/avatar.dart';
import 'package:school_violence_app/app/modules/profile/widgets/customLabel.dart';
import 'package:school_violence_app/app/modules/profile/widgets/fullNameTextField.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late TextEditingController _controller;

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
  final SignInController signInCtrl = Get.find<SignInController>();
  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (Get.isDialogOpen == false) {
          helpDialog(signInCtrl.userId.value);
        }
      },
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              const SizedBox(height: 35),

              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(const ProfilePage());
                    },
                    child: Image.asset(
                      'assets/images/left-small.png',
                      width: 28,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    'Personal Info',
                    style: CustomTextStyle.h1(AppColors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const PersonalAvatar(
                imageLink: 'assets/images/personal_img.png',
              ),
              const SizedBox(height: 26),
              // FULL NAME
              const CustomLabel(text: 'Full Name'),
              const FullNameTextField(),
              const SizedBox(height: 24),
              // EMAIL
              const CustomLabel(text: 'Email'),
              const EmailTextField(),
              const SizedBox(height: 24),
              // PHONE NUMBER
              const CustomLabel(text: 'Phone Number'),
              IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              // Date of Birth
              const CustomLabel(text: 'Date of Birth'),
              DOBInputField(
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                showLabel: true,
                dateFormatType: DateFormatType.DDMMYYYY,
                autovalidateMode: AutovalidateMode.always,
              ),
              // Đám này nhờ Tính tạo list giùm
              const CustomLabel(text: 'Country'),
              const EmailTextField(),
              const SizedBox(height: 24),
              const CustomLabel(text: 'Province'),
              const EmailTextField(),
              const SizedBox(height: 24),
              const CustomLabel(text: 'City'),
              const EmailTextField(),
              const SizedBox(height: 24),
              const CustomLabel(text: 'High School'),
              const EmailTextField(),
              const SizedBox(height: 50),
              const Center(
                child: Button(
                  text: 'Save',
                  toScreen: ProfilePage(),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
