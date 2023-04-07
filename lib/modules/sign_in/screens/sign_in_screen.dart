import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/app_text_style.dart';
import '../../../routes/app_routes.dart';
import '../sign_in_controller.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/sign_in_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final SignInController ctrl = Get.find<SignInController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          reverse: true,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 5,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                AppStrings().appName,
                                style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 5,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Hello there',
                                style: TextStyle(
                                  color: AppColors.desc,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.waving_hand_rounded,
                                color: AppColors.desc,
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/logo-protected.png',
                              fit: BoxFit.fill,
                              scale: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                      const SizedBox(
                        //width: 400,
                        height: 40,
                      ),
                      // IconButton(
                      //   onPressed: () => Get.back(),
                      //   alignment: Alignment.topLeft,
                      //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                      //   icon: Icon(Icons.arrow_back),
                      //   iconSize: 30,
                      // ),
                      EmailField(
                        emailController: ctrl.emailController,
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        ctrl: ctrl,
                        passwordController: ctrl.passwordController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: ctrl.remember.value,
                                  onChanged: ((value) => ctrl.updateRemember()),
                                  activeColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              Text(
                                'Remember me',
                                textAlign: TextAlign.left,
                                style: CustomTextStyle.label(AppColors.desc),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.forgotPassword);
                            },
                            child: Text(
                              'Forgot Password?',
                              style:
                                  CustomTextStyle.label(AppColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 130),
                          SizedBox(
                            height: 53,
                            width: 382,
                            child: SignInButton(formKey: _formKey, ctrl: ctrl),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: CustomTextStyle.label(
                                    AppColors.dontHaveAccount),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.signUp);
                                },
                                child: Text(
                                  'Sign up',
                                  style: CustomTextStyle.label(
                                      AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
