import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/forgot_passwords.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/new_passwords.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/button.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
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
              SizedBox(height: 35),

              IconButton(
                onPressed: () => Get.to(ForgotPasswordPage()),
                icon: Icon(Icons.arrow_back),
                iconSize: 30,
                padding: EdgeInsets.only(right: double.infinity),
              ),
              SizedBox(height: 35),
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
              SizedBox(height: 7),
              Row(
                children: [
                  Text(
                    'We have sent the OTP verification code to \nyour email address. Check your mail and \nenter the code below.',
                    style: CustomTextStyle.desc(AppColors.desc),
                  ),
                ],
              ),
              SizedBox(height: 45),
              OtpTextField(
                numberOfFields: 4,
                borderColor: Color(0xFF512DA8),
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
                          title: Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      });
                }, // end onSubmit
              ),
              SizedBox(height: 45),
              Center(
                child: Text(
                  'Didn’t receive email?',
                  style: CustomTextStyle.desc(AppColors.desc),
                ),
              ),
              SizedBox(height: 14),
              Center(
                child: Text(
                  'You can resend code in 55 s',
                  style: CustomTextStyle.desc(AppColors.desc),
                ),
              ),
              SizedBox(height: 55),
              Center(
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
