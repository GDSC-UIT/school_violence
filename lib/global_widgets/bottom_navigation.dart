import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/values/app_colors.dart';
import '../core/values/app_text_style.dart';
import '../routes/app_routes.dart';

class BottomNavigation extends StatefulWidget {
  final int onItem;
  const BottomNavigation({super.key, required this.onItem});

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
          break;
          // Get.toNamed(AppRoutes.profile);
        }
      case 4:
        {
          Get.toNamed(AppRoutes.map);
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: CustomTextStyle.smallDesc(AppColors.primaryColor),
      unselectedLabelStyle: CustomTextStyle.smallDesc(AppColors.black),
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Chat',
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
