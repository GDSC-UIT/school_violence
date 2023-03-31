import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/data/services/auth_services.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/data/services/emergency.dart';
import 'package:school_violence_app/app/global_widgets/bottom_navigation.dart';
import 'package:school_violence_app/app/global_widgets/help_dialog.dart';
import 'package:school_violence_app/app/modules/profile/widgets/customItem.dart';
import 'package:school_violence_app/app/modules/profile/widgets/profileNameCard.dart';
import 'package:school_violence_app/app/modules/sign_in/screens/sign_in_screen.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  bool pressGeoON = false;
  bool cmbscritta = false;
  late TextEditingController _controller;
  late TabController _tabController;
  final AuthServices _auth = AuthServices();
  final SignInController signInCtrl = Get.find<SignInController>();
  final Connect _connect = Connect();
  final Emergency _emergency = Emergency();
  List _friends = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
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
        bottomNavigationBar: BottomNavigation(
          onItem: 3,
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
                          'assets/images/avatar.jpg', // Avatar
                          width: 48,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Profile',
                          style: CustomTextStyle.h1(AppColors.black),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(
                            SignInPage()); // Chỗ này nên bắn ra dialog confirm
                        _auth.signOutWithEmailAndPassword();
                      },
                      child: Image.asset(
                        'assets/images/logout.png', // Logout
                        width: 48,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 29),
                SizedBox(
                  width: 400,
                  height: 126,
                  child: Image.asset('assets/images/profile_img.png',
                      fit: BoxFit.contain),
                ),
                const SizedBox(height: 16),
                const ProfileNameCard(
                    name: 'Cao Minh Quân', phoneNumber: '+84 123456789'),
                const SizedBox(height: 30),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: TabBar(
                          unselectedLabelStyle:
                              CustomTextStyle.button(AppColors.primaryColor),
                          indicator: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(50), // Creates border
                            color: AppColors.primaryColor,
                          ),
                          labelStyle: CustomTextStyle.button(AppColors.white),
                          labelPadding: const EdgeInsets.all(14),
                          // padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.primaryColor,
                          controller: _tabController,
                          tabs: const [Text('Report'), Text('Diary')],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.maxFinite,
                        height: 270,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // LIST REPORT
                            ListView.builder(
                              itemCount: 2, // length
                              scrollDirection: Axis.vertical,
                              itemBuilder: (_, index) {
                                return CustomReportItem(
                                  title: 'Location',
                                  subtitle: '3 days ago',
                                  text: '36 59.35333 -84 13.888333',
                                  thumbnail: Image.asset(
                                      'assets/images/avatar.jpg',
                                      height: 100),
                                );
                              },
                            ),
                            // LIST DIARY
                            ListView.builder(
                              itemCount: 2, // length
                              scrollDirection: Axis.vertical,
                              itemBuilder: (_, index) {
                                return CustomReportItem(
                                  title: 'Chat',
                                  subtitle: 'Today',
                                  text: 'Seen',
                                  thumbnail: Image.asset(
                                      'assets/images/avatar.jpg',
                                      height: 100),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shadowColor: AppColors.primaryColorShadow,
                          elevation: 5,
                          minimumSize: const Size(382, 54),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: Text(
                          'Start',
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.button(AppColors.white),
                        ),
                      ),
                    ],
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
