import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInButton extends StatelessWidget {
  SignInButton({
    Key? key,
    required formKey,
    required ctrl,
  })  : _formKey = formKey,
        signInCtrl = ctrl,
        super(key: key);

  final AuthServices _auth = AuthServices();
  final SignInController signInCtrl;
  final GlobalKey<FormState> _formKey;
  final CollectionReference connectCollection =
      FirebaseFirestore.instance.collection('connect');
  void getData() async {
    DocumentSnapshot snapUsers = await FirebaseFirestore.instance
        .collection('users')
        .doc(signInCtrl.userId.value)
        .get();
    if (snapUsers.data() != null) {
      signInCtrl.updateUserName((snapUsers.data()! as dynamic)['userName']);
      signInCtrl.updateEmail((snapUsers.data()! as dynamic)['email']);
      signInCtrl.updatePassword((snapUsers.data()! as dynamic)['password']);
      signInCtrl.updateFullName((snapUsers.data()! as dynamic)['fullName']);
      signInCtrl
          .updateDateOfBirth((snapUsers.data()! as dynamic)['dateOfBirth']);
      signInCtrl
          .updatePhoneNumber((snapUsers.data()! as dynamic)['phoneNumber']);
      signInCtrl.updateCountry((snapUsers.data()! as dynamic)['country']);
      signInCtrl.updateProvince((snapUsers.data()! as dynamic)['province']);
      signInCtrl.updateCity((snapUsers.data()! as dynamic)['city']);
      signInCtrl.updateSchool((snapUsers.data()! as dynamic)['school']);
      signInCtrl.updateExpert((snapUsers.data()! as dynamic)['expert']);
    }
  }

  void checkHelp() async {
    DocumentSnapshot snapEmergency = await FirebaseFirestore.instance
        .collection('emergency')
        .doc(signInCtrl.userId.value)
        .get();
    if (snapEmergency.data() != null) {
      signInCtrl.updateFriendId((snapEmergency.data()! as dynamic)['friendId']);
    } else {
      signInCtrl.updateFriendId([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          String? result = await _auth.signInWithEmailAndPassword(
            signInCtrl.emailController.text,
            signInCtrl.passwordController.text,
          );
          if (result != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', signInCtrl.emailController.text);
            prefs.setString('password', signInCtrl.passwordController.text);
            signInCtrl.updateUserId(result);
            getData();
            Timer.periodic(
              const Duration(milliseconds: 100),
              (timer) {
                checkHelp();
              },
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        // shadowColor: AppColors.primaryColorShadow,
        // elevation: 5,
        minimumSize: const Size(360, 50),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      child: Text(
        'SIGN IN',
        textAlign: TextAlign.center,
        style: CustomTextStyle.button(AppColors.white),
      ),
    );
  }
}
