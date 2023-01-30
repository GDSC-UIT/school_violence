import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_violence_app/app/core/utils/utils.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/database.dart';
import 'package:school_violence_app/app/modules/intro/screens/intro_screen.dart';
import 'package:school_violence_app/app/routes/app_pages.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Google

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  Future googleLogIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User? user = (await _auth
        .signInWithCredential(credential)
        .then((value) => Get.offAll(HomePage())));
  }

  Future googleLogOut() async {
    await _auth.signOut().then((value) => Get.offAll(IntroPage()));
    await googleSignIn.signOut();
  }

  // Register

  Future signUp(
      String userName,
      String email,
      String password,
      String fullName,
      String dateOfBirth,
      String phoneNumber,
      String country,
      String province,
      String city,
      String school) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(user!.uid);
      await DatabaseService(uid: user.uid).updateUserData(
        userName,
        email,
        password,
        fullName,
        dateOfBirth,
        phoneNumber,
        country,
        province,
        city,
        school,
      );
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else {
        message = e.message.toString();
      }
      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.white);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.white);
    }
    //Get.offAll(() => AppRoutes.intro);
  }

  //Apple

  // Future appleLogIn() async {
  //   final appleIdCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //   );

  //   final oAuthProvider = OAuthProvider('apple.com');

  //   final credential = oAuthProvider.credential(
  //     idToken: appleIdCredential.identityToken,
  //     accessToken: appleIdCredential.authorizationCode,
  //   );

  //   final User? user = (await _auth
  //       .signInWithCredential(credential)
  //       .then((value) => Get.offAll(HomePage())));
  // }

  // Future appleLogOut() async {
  //   await _auth.signOut().then((value) => Get.toNamed(AppRoutes.intro));
  //   await appleLogOut();
  // }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            AuthServices().googleLogOut();
          },
          child: Text('Sign Out'),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     AuthServices().googleLogOut();
        //   },
        //   child: Text('Sign Out'),
        // ),
      ],
    );
  }
}
