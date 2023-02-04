import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/forgot_passwords_binding.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/forgot_passwords.dart';
import 'package:school_violence_app/app/modules/home_page/home_page_binding.dart';
import 'package:school_violence_app/app/modules/home_page/screens/home_page.dart';
import 'package:school_violence_app/app/modules/intro/intro_binding.dart';
import 'package:school_violence_app/app/modules/intro/screens/intro_screen.dart';
import 'package:school_violence_app/app/modules/intro/screens/loading_screen.dart';
import 'package:school_violence_app/app/modules/sign_up/screens/sign_up_screen.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_bingding.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.loading,
      page: () => const LoadingPage(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: AppRoutes.intro,
      page: () => IntroPage(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: AppRoutes.sign_up,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.forgot_password,
      page: () => ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomePageBinding(),
    ),
  ];
}
