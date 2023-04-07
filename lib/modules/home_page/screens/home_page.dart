import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../data/services/connect.dart';
import '../../../data/services/emergency.dart';
import '../../../global_widgets/bottom_navigation.dart';
import '../../../global_widgets/help_dialog.dart';
import '../../../routes/app_routes.dart';
import '../../sign_in/sign_in_controller.dart';
import '../models/app_banner.dart';
import '../models/school_club.dart';
import '../widgets/name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SignInController signInCtrl = Get.find<SignInController>();
  final Connect _connect = Connect();
  final Emergency _emergency = Emergency();
  List _friends = [];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return EmergencyDialog();
    //     },
    //   );
    // });
    // _controller = TextEditingController();
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
    getData();
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (Get.isDialogOpen == false) {
          helpDialog(signInCtrl.userId.value);
        }
      },
    );
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(
        onItem: 0,
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
              const SizedBox(height: 32),

              Name(),
              const SizedBox(height: 30),
              Image.asset('assets/images/home_img.png',
                  width: 380, height: 160, fit: BoxFit.fill),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discover',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      log('Hello');
                    },
                    child: Row(
                      children: const [
                        Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          weight: 500,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 14.0,
                ),
                height: 240,
                child: PageView.builder(
                  controller: PageController(
                    viewportFraction: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        log('Hello');
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 5.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.dontHaveAccount.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              child: Image.network(
                                appBannerList[index].thumbnailUrl,
                                height: 130,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  appBannerList[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                appBannerList[index].author,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: appBannerList.length,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Clubs',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      log('Hello');
                    },
                    child: Row(
                      children: const [
                        Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          weight: 500,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: PageController(
                    viewportFraction: 0.3,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.club,
                          arguments: schoolClubList[index],
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(60),
                        //   ),
                        //   // boxShadow: [
                        //   //   BoxShadow(
                        //   //     color: AppColors.primaryColor.withOpacity(0.5),
                        //   //     spreadRadius: 2,
                        //   //     blurRadius: 4,
                        //   //   ),
                        //   // ],
                        //   color: AppColors.primaryColor,
                        // ),
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          backgroundImage: NetworkImage(
                            schoolClubList[index].avatarUrl,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 120,
                              ),
                              Text(
                                schoolClubList[index].standFor,
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: schoolClubList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
