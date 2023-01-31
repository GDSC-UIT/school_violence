import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/email.dart';

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

              Image.asset(
                'assets/images/left-small.png',
                width: 28,
              ),
              SizedBox(height: 35),
              Row(
                children: [
                  Text(
                    'Forgot Password ',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      color: AppColors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.asset(
                    'assets/images/key.png',
                    width: 28,
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Text(
                    'Enter your email address to get an code \n to reset your password.',
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
              SizedBox(height: 49),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  color: AppColors.black,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 0.4, color: AppColors.primaryColorShadow),
                  ),
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.transparent, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2.0),
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter an Full Name' : null,
                  onChanged: (val) {
                    //setState(() => userName = val);
                  },
                ),
              ),
              SizedBox(height: 300),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(EmailPage());
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
                    'Continue',
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
