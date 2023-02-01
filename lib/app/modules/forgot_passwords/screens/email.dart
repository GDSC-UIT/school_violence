import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/forgot_passwords.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/new_passwords.dart';

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

              InkWell(
                onTap: () {
                  Get.to(ForgotPasswordPage());
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
                    'You ‘ve got mail ',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      color: AppColors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.asset(
                    'assets/images/mail.png',
                    width: 28,
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Text(
                    'We have sent the OTP verification code to \n your email address. Check your mail and \n enter the code below.',
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
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(56, 56, 56, 1),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 14),
              Center(
                child: Text(
                  'You can resend code in 55 s',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(56, 56, 56, 1),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 55),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(NewPassWordPage());
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
                    'Confirm',
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
    );
  }
}
