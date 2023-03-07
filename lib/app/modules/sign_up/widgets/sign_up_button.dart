import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class SignUpButton extends StatelessWidget {
  SignUpButton({
    Key? key,
    required formKey,
    required fullNameController,
    required dateController,
    required phoneNumberController,
    required country,
    required province,
    required city,
    required school,
  })  : _formKey = formKey,
        super(key: key);

  final SignUpController ctrl = Get.find<SignUpController>();
  final AuthServices _auth = AuthServices();
  final GlobalKey<FormState> _formKey;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          String userName = ctrl.userNameController.text.trim();
          String email = ctrl.emailController.text.trim();
          String password = ctrl.passwordController.text.trim();
          String fullName = ctrl.fullNameController.text.trim();
          String dateOfBirth = ctrl.dateController.text.trim();
          String phoneNumber = ctrl.phoneNumberController.text.trim();
          String countryName = ctrl.countryName;
          String provinceName = ctrl.provinceName;
          String cityName = ctrl.cityName;
          String schoolName = ctrl.schoolName;
          await _auth.signUp(
            userName,
            email,
            password,
            fullName,
            dateOfBirth,
            phoneNumber,
            countryName,
            provinceName,
            cityName,
            schoolName,
            false,
            0,
            0,
          );
          Get.dialog(
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 341,
                height: 474,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 168,
                      height: 159,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                      ),
                    ),

                    //

                    SizedBox(height: 10),

                    //

                    Text(
                      'Successful!',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 24,
                        fontFamily: 'Montserrat',
                      ),
                    ),

                    //

                    SizedBox(height: 10),

                    //

                    Text(
                      'Please wait  a moment, we are\npreparing for you...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),

                    //

                    SizedBox(height: 50),

                    //

                    SpinKitCircle(
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          );
          if (Get.isDialogOpen == true) {
            await 2.seconds.delay();
            Get.toNamed(AppRoutes.sign_in);
          }
        }
      },
      child: Text(
        'Sign Up',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.primaryColorShadow,
        elevation: 5,
        minimumSize: const Size(300, 40),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
