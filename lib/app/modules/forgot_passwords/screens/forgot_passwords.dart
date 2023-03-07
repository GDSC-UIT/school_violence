import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/email.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/button.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/input_label.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/text_field_email.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back),
                iconSize: 30,
                padding: EdgeInsets.only(right: double.infinity),
              ),
              SizedBox(height: 35),
              Row(
                children: [
                  Text(
                    'Forgot Password ',
                    style: CustomTextStyle.h1(AppColors.black),
                  ),
                  Image.asset(
                    'assets/images/key.png',
                    width: 24,
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Text(
                    'Enter your email address to get an code \nto reset your password.',
                    style: CustomTextStyle.desc(AppColors.desc),
                  ),
                ],
              ),
              SizedBox(height: 49),
              InputLabel(text: 'Email'),
              TextFieldEmail(),
              SizedBox(height: 300),
              Button(
                text: 'Continue',
                toScreen: EmailPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
