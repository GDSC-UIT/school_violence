import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../widgets/button.dart';
import 'forgot_passwords.dart';
import 'new_passwords.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              const SizedBox(height: 35),

              IconButton(
                onPressed: () => Get.to(const ForgotPasswordPage()),
                icon: const Icon(Icons.arrow_back),
                iconSize: 30,
                padding: const EdgeInsets.only(right: double.infinity),
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  Text(
                    'You ‘ve got mail ',
                    style: CustomTextStyle.h1(AppColors.black),
                  ),
                  Image.asset(
                    'assets/images/mail.png',
                    width: 24,
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Text(
                    'We have sent the OTP verification code to \nyour email address. Check your mail and \nenter the code below.',
                    style: CustomTextStyle.desc(AppColors.desc),
                  ),
                ],
              ),
              const SizedBox(height: 45),
              OtpTextField(
                numberOfFields: 4,
                borderColor: const Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      });
                }, // end onSubmit
              ),
              const SizedBox(height: 45),
              Center(
                child: Text(
                  'Didn’t receive email?',
                  style: CustomTextStyle.desc(AppColors.desc),
                ),
              ),
              const SizedBox(height: 14),
              Center(
                child: Text(
                  'You can resend code in 55 s',
                  style: CustomTextStyle.desc(AppColors.desc),
                ),
              ),
              const SizedBox(height: 55),
              const Center(
                child: Button(
                  text: 'Confirm',
                  toScreen: NewPassWordPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
