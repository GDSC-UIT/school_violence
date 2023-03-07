import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

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
  final NotificationsController notifycationsCtrl =
      Get.find<NotificationsController>();
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

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          dynamic result = await _auth.signInWithEmailAndPassword(
            signInCtrl.emailController.text,
            signInCtrl.passwordController.text,
          );
          if (result != null) {
            signInCtrl.updateUserId(result);
            getData();
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shadowColor: AppColors.primaryColorShadow,
        elevation: 5,
        minimumSize: const Size(300, 40),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      child: Text(
        'Sign In',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
