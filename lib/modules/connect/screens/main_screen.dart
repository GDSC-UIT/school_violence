import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../../../data/services/connect.dart';
import '../../../data/services/emergency.dart';
import '../../../global_widgets/bottom_navigation.dart';
import '../../../global_widgets/help_dialog.dart';
import '../../../routes/app_routes.dart';
import '../../sign_in/sign_in_controller.dart';
import '../widgets/list_friend.dart';
import '../widgets/name_card.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage>
    with TickerProviderStateMixin {
  bool pressGeoON = false;
  bool cmbscritta = false;
  final SignInController signInCtrl = Get.find<SignInController>();
  List<String> products = ["BED", "SOFA", "CHAIR"];
  ListFriend list = ListFriend();
  final Connect _connect = Connect();
  final Emergency _emergency = Emergency();
  List _friends = [];

  @override
  void initState() {
    super.initState();
  }

  void getData() async {
    DocumentSnapshot snap =
        await _connect.connectCollection.doc(signInCtrl.userId.value).get();
    if (snap.data() != null) {
      _friends = (snap.data()! as dynamic)['friends'];
    } else {
      _friends = [];
    }
  }

  void sendHelp() {
    for (int i = 0; i < _friends.length; i++) {
      _emergency.needHelp(signInCtrl.userId.value, _friends[i]);
    }
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (Get.isDialogOpen == false) {
          helpDialog(signInCtrl.userId.value);
        }
      },
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: const BottomNavigation(
          onItem: 2,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            sendHelp();
            Get.toNamed(AppRoutes.map);
          },
          backgroundColor: AppColors.primaryColor,
          child: Image.asset('assets/icons/map_icon.png'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/grey-avatar.png',
                          width: 28,
                        ),
                        const SizedBox(width: 22.5),
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
                      child: const Icon(Icons.search, size: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 29),
                SizedBox(
                  width: 380,
                  height: 120,
                  child: Image.asset('assets/images/connect_img.png',
                      fit: BoxFit.contain),
                ),
                const SizedBox(height: 16),
                Text(
                  'Your friend',
                  style: CustomTextStyle.h2(AppColors.black),
                ),
                SizedBox(
                  width: double.infinity,
                  height: list.listFriend.length * 100,
                  child: ListView.builder(
                    itemCount: list.listFriend.length,
                    itemBuilder: (context, index) {
                      return FriendCard(
                          name: list.listFriend[index].name,
                          phoneNumber: list.listFriend[index].phoneNumber,
                          avatarLink: list.listFriend[index].avatarLink);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
