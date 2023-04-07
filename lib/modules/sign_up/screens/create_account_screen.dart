import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../sign_up_controller.dart';
import '../widgets/apple_sign_in_button.dart';
import '../widgets/continue_button.dart';
import '../widgets/email_field.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/password_field.dart';
import '../widgets/user_name_field.dart';

SingleChildScrollView createAccount() {
  final SignUpController ctrl = Get.find<SignUpController>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  return SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 35),
            Text(
              'Create an account',
              style: CustomTextStyle.h1(AppColors.black),
            ),
            const SizedBox(height: 30),
            Text(
              'Please enter your username, email address\nand password. If you forget it, then you have \nto do forgot password.',
              textAlign: TextAlign.center,
              style: CustomTextStyle.desc(AppColors.desc),
            ),
            const SizedBox(height: 30),
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
                const SizedBox(height: 20),
                Text(
                  'Email',
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.label(AppColors.black),
                ),
                EmailField(
                  emailController: ctrl.emailController,
                ),
                const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: CustomTextStyle.smallDesc(AppColors.black),
            ),

            // Sign In with Google

            const GoogleSignInButton(),
            const SizedBox(height: 10),

            // Sign In with Apple

            const AppleSignInButton(),
            const SizedBox(height: 10),

            // Continue

            ContinueButton(
              ctrl: ctrl,
              formKey: formKey,
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
