import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class BottomNavigation extends StatefulWidget {
  late int onItem;
  BottomNavigation({super.key, required this.onItem});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        {
          Get.toNamed(
            AppRoutes.home,
          );
          break;
        }
      case 1:
        {
          Get.toNamed(AppRoutes.diary);
          break;
        }
      case 2:
        {
          Get.toNamed(AppRoutes.connect);
          break;
        }
      case 3:
        {

          Get.toNamed(AppRoutes.profile);

          // Get.toNamed(AppRoutes.profile);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded),
          label: 'Diary',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.connect_without_contact),
          label: 'Connect',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.onItem,
      selectedItemColor: AppColors.primaryColor,
      onTap: _onItemTapped,
    );
  }
}
