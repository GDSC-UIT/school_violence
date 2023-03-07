import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:school_violence_app/app/modules/sign_in/widgets/email_field.dart';
import 'package:school_violence_app/app/modules/sign_in/widgets/password_field.dart';
import 'package:school_violence_app/app/modules/sign_in/widgets/sign_in_button.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final SignInController ctrl = Get.find<SignInController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  //width: 400,
                  height: 40,
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30,
                ),
                SizedBox(
                  //width: 300,
                  height: 30,
                ),
                Wrap(
                  children: [
                    Text(
                      'Hello there',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.h1(AppColors.black),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.waving_hand_rounded),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  'Email',
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.label(AppColors.black),
                ),
                EmailField(
                  emailController: ctrl.emailController,
                ),
                SizedBox(height: 20),
                Text(
                  'Password',
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.label(AppColors.black),
                ),
                PasswordField(
                  ctrl: ctrl,
                  passwordController: ctrl.passwordController,
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: ctrl.remember.value,
                        onChanged: ((value) => ctrl.updateRemember()),
                      ),
                    ),
                    Text(
                      'Remember me',
                      textAlign: TextAlign.left,
                      style: CustomTextStyle.label(AppColors.black),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 400,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.forgot_password);
                    },
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.label(AppColors.primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 200),
                SizedBox(
                  height: 53,
                  width: 382,
                  child: SignInButton(formKey: _formKey, ctrl: ctrl),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
