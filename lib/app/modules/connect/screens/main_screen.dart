import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/global_widgets/bottom_navigation.dart';
import 'package:school_violence_app/app/global_widgets/help_dialog.dart';
import 'package:school_violence_app/app/modules/connect/widgets/list_friend.dart';
import 'package:school_violence_app/app/modules/connect/widgets/name_card.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/email.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage>
    with TickerProviderStateMixin {
  bool pressGeoON = false;
  bool cmbscritta = false;
  late TextEditingController _controller;
  late TabController _tabController;
  final SignInController signInCtrl = Get.find<SignInController>();
  List<String> products = ["BED", "SOFA", "CHAIR"];
  ListFriend list = ListFriend();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      new Duration(seconds: 1),
      (timer) {
        helpDialog(signInCtrl.userId.value);
      },
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigation(
          onItem: 2,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/grey-avatar.png',
                          width: 28,
                        ),
                        SizedBox(width: 22.5),
                        Text(
                          'Connect',
                          style: CustomTextStyle.h1(AppColors.black),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.findFriends);
                      },
                      child: Icon(Icons.search, size: 30),
                    ),
                  ],
                ),
                SizedBox(height: 29),
                Container(
                  child: Image.asset('assets/images/connect_img.png',
                  fit: BoxFit.contain),
                  width: 380,
                  height: 120,
                ),
                SizedBox(height: 16),
                Text(
                  'Your friend',
                  style: CustomTextStyle.h2(AppColors.black),
                ),
                Container(
                  child: ListView.builder(
                    itemCount: list.listFriend.length,
                    itemBuilder: (context, index) {
                      return FriendCard(
                          name: list.listFriend[index].name,
                          phoneNumber: list.listFriend[index].phoneNumber,
                          avatarLink: list.listFriend[index].avatarLink);
                    },
                  ),
                  width: double.infinity,
                  height: list.listFriend.length * 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
