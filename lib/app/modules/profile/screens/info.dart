import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/forgot_passwords.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/new_passwords.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/widgets/button.dart';
import 'package:school_violence_app/app/modules/profile/screens/profile.dart';
import 'package:school_violence_app/app/modules/profile/widgets/avatar.dart';
import 'package:school_violence_app/app/modules/profile/widgets/customLabel.dart';
import 'package:school_violence_app/app/modules/profile/widgets/fullNameTextField.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
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

              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(ProfilePage());
                    },
                    child: Image.asset(
                      'assets/images/left-small.png',
                      width: 28,
                    ),
                  ),
                  SizedBox(width: 24),
                  Text(
                    'Personal Info',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      color: AppColors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              PersonalAvatar(
                imageLink: 'assets/images/avatar.jpg',
              ),
              SizedBox(height: 26),
              CustomLabel(text: 'Full Name'),
              FullNameTextField(),
              SizedBox(height: 24),
              CustomLabel(text: 'Email'),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              SizedBox(height: 45),
              Center(
                child: Text(
                  'Didn’t receive email?',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(56, 56, 56, 1),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 14),
              Center(
                child: Text(
                  'You can resend code in 55 s',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(56, 56, 56, 1),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 55),
              Center(
                child: Button(
                  text: 'Confirm',
                  toScreen: NewPassWordPage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
