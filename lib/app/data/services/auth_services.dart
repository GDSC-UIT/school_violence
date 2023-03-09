import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/database.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

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
        .then((value) => Get.offAll(AppRoutes.home)));
  }

  Future googleLogOut() async {
    await _auth.signOut().then((value) => Get.toNamed(AppRoutes.intro));
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
    String school,
    bool expert,
    double latitude,
    double longtitude,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(
        user.uid,
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
        expert,
        latitude,
        longtitude,
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

  //Sign in

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      Get.toNamed(AppRoutes.home);
      return user != null ? user.uid : null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out

  Future signOutWithEmailAndPassword() async {
    _auth.signOut();
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
