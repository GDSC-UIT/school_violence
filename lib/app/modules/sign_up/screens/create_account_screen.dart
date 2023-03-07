import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/sign_up/widgets/apple_sign_in_button.dart';
import 'package:school_violence_app/app/modules/sign_up/widgets/continue_button.dart';
import 'package:school_violence_app/app/modules/sign_up/widgets/email_field.dart';
import 'package:school_violence_app/app/modules/sign_up/widgets/google_sign_in_button.dart';
import 'package:school_violence_app/app/modules/sign_up/widgets/password_field.dart';
import 'package:school_violence_app/app/modules/sign_up/widgets/user_name_field.dart';

SingleChildScrollView createAccount() {
  final SignUpController ctrl = Get.find<SignUpController>();

  final AuthServices _auth = AuthServices();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: 35),
            Text(
              'Create an account',
              style: CustomTextStyle.h1(AppColors.black),
            ),
            SizedBox(height: 30),
            Text(
              'Please enter your username, email address\nand password. If you forget it, then you have \nto do forgot password.',
              textAlign: TextAlign.center,
              style: CustomTextStyle.desc(AppColors.desc),
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Name',
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.label(AppColors.black),
                ),
                UserNameField(
                  userNameController: ctrl.userNameController,
                ),
                SizedBox(height: 20),
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
              ],
            ),
            SizedBox(height: 20),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: CustomTextStyle.small_desc(AppColors.black),
            ),

            // Sign In with Google

            GoogleSignInButton(),
            SizedBox(height: 10),

            // Sign In with Apple

            AppleSignInButton(),
            SizedBox(height: 10),

            // Continue

            ContinueButton(
              ctrl: ctrl,
              formKey: _formKey,
              userNameController: ctrl.userNameController,
              emailController: ctrl.emailController,
              passwordController: ctrl.passwordController,
            ),
          ],
        ),
      ),
    ),
  );
}
