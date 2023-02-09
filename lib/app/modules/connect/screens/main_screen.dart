import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/global_widgets/bottom_navigation.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class ConnectPage extends StatelessWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigation(onItem: 2,),
        body: IconButton(
          icon: Icon(Icons.search),
          iconSize: 50,
          onPressed: () {
            Get.toNamed(AppRoutes.findFriends);
          },
        ),
      ),
    );
  }
}
