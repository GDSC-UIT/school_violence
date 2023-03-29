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

  final AuthServices auth = AuthServices();

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
              style: CustomTextStyle.small_desc(AppColors.black),
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
