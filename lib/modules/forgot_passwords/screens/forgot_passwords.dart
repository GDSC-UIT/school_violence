import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../widgets/button.dart';
import '../widgets/input_label.dart';
import '../widgets/text_field_email.dart';
import 'email.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back),
                iconSize: 30,
                padding: const EdgeInsets.only(right: double.infinity),
              ),
              const SizedBox(height: 35),
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
              const SizedBox(height: 7),
              Row(
                children: [
                  Text(
                    'Enter your email address to get an code \nto reset your password.',
                    style: CustomTextStyle.desc(AppColors.desc),
                  ),
                ],
              ),
              const SizedBox(height: 49),
              const InputLabel(text: 'Email'),
              const TextFieldEmail(),
              const SizedBox(height: 300),
              const Button(
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
