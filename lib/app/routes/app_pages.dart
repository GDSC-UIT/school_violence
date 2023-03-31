import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/connect/connect_binding.dart';
import 'package:school_violence_app/app/modules/connect/screens/find_friends.dart';
import 'package:school_violence_app/app/modules/connect/screens/main_screen.dart';
import 'package:school_violence_app/app/modules/diary/diary_binding.dart';
import 'package:school_violence_app/app/modules/diary/screens/diary.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/forgot_passwords_binding.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/forgot_passwords.dart';
import 'package:school_violence_app/app/modules/home_page/home_page_binding.dart';
import 'package:school_violence_app/app/modules/home_page/screens/home_page.dart';
import 'package:school_violence_app/app/modules/intro/intro_binding.dart';
import 'package:school_violence_app/app/modules/intro/screens/intro_screen.dart';
import 'package:school_violence_app/app/modules/intro/screens/loading_screen.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_binding.dart';
import 'package:school_violence_app/app/modules/notifications/screens/notifications.dart';
import 'package:school_violence_app/app/modules/profile/screens/info.dart';
import 'package:school_violence_app/app/modules/profile/screens/profile.dart';
import 'package:school_violence_app/app/modules/profile/profile_binding.dart';
import 'package:school_violence_app/app/modules/sign_in/screens/sign_in_screen.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_binding.dart';
import 'package:school_violence_app/app/modules/sign_up/screens/sign_up_screen.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_bingding.dart';
import '../modules/map/map_binding.dart';
import '../modules/map/main_map.dart';
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
      name: AppRoutes.sign_in,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.forgot_password,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
        binding: HomePageBinding(),
        transition: Transition.noTransition),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsPage(),
      binding: NotificationsBinding(),
    ),
    GetPage(
        name: AppRoutes.connect,
        page: () => const ConnectPage(),
        binding: ConnectBinding(),
        transition: Transition.noTransition),
    GetPage(
      name: AppRoutes.findFriends,
      page: () => FindFriends(),
      binding: ConnectBinding(),
    ),
    GetPage(
        name: AppRoutes.diary,
        page: () => const DiaryPage(),
        binding: DiaryBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.profile,
        page: () => const ProfilePage(),
        binding: ProfileBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.info,
        page: () => const PersonalInfoPage(),
        binding: ProfileBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: AppRoutes.map,
        page: () => const MyMap(),
        binding: MapBinding(),
        transition: Transition.noTransition),
  ];
}
