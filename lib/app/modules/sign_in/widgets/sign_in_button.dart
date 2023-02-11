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
    required this.ctrl,
  })  : _formKey = formKey,
        super(key: key);

  final AuthServices _auth = AuthServices();
  final SignInController ctrl;
  final ConnectController connectCtrl = Get.find<ConnectController>();
  final NotificationsController notifycationsCtrl =
      Get.find<NotificationsController>();
  final GlobalKey<FormState> _formKey;
  final CollectionReference connectCollection =
      FirebaseFirestore.instance.collection('connect');

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          dynamic result = await _auth.signInWithEmailAndPassword(
            ctrl.emailController.text,
            ctrl.passwordController.text,
          );
          if (result != null) {
            connectCtrl.updateUserId(result);
            DocumentSnapshot snap =
                await connectCollection.doc(connectCtrl.userId.value).get();
            if (snap.data() != null) {
              notifycationsCtrl.updateFriendRequest(
                  (snap.data()! as dynamic)['friendRequest']);
            } else {
              notifycationsCtrl.updateFriendRequest([]);
            }
            //print(notifycationsCtrl.friendRequest);
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
