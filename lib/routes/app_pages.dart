import 'package:get/get.dart';
import '../modules/connect/connect_binding.dart';
import '../modules/connect/screens/find_friends.dart';
import '../modules/connect/screens/main_screen.dart';
import '../modules/diary/diary_binding.dart';
import '../modules/diary/screens/diary.dart';
import '../modules/forgot_passwords/forgot_passwords_binding.dart';
import '../modules/forgot_passwords/screens/forgot_passwords.dart';
import '../modules/home_page/home_page_binding.dart';
import '../modules/home_page/screens/club_detail.dart';
import '../modules/home_page/screens/discover_screen.dart';
import '../modules/home_page/screens/home_page.dart';
import '../modules/intro/intro_binding.dart';
import '../modules/intro/screens/intro_screen.dart';
import '../modules/intro/screens/loading_screen.dart';
import '../modules/map/map_binding.dart';
import '../modules/map/main_map.dart';
import '../modules/notifications/notifications_binding.dart';
import '../modules/notifications/screens/notifications.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/screens/info.dart';
import '../modules/profile/screens/profile.dart';
import '../modules/sign_in/screens/sign_in_screen.dart';
import '../modules/sign_in/sign_in_binding.dart';
import '../modules/sign_up/screens/sign_up_screen.dart';
import '../modules/sign_up/sign_up_bingding.dart';
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
      name: AppRoutes.signUp,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
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
    GetPage(
      name: AppRoutes.club,
      page: () => const ClubDetailScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.discover,
      page: () => const DiscoverDetailScreen(),
      transition: Transition.noTransition,
    )
  ];
}
