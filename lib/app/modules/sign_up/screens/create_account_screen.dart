import 'package:flutter/material.dart';
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
      child: Column(
        children: [
          SizedBox(height: 35),
          Text(
            'Create an account',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Please enter your username, email address\nand password. If you forget it, then you have \nto do forgot password.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'User Name',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
              UserNameField(userNameController: ctrl.userNameController,),
              SizedBox(height: 20),
              const Text(
                'Email',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
              EmailField(emailController:  ctrl.emailController,),
              SizedBox(height: 20),
              const Text(
                'Password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
              PasswordField(ctrl: ctrl, passwordController: ctrl.passwordController,),
            ],
          ),
          SizedBox(height: 20),
          const Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
            ),
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
  );
}
