import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/global_widgets/help_dialog.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';
import 'package:school_violence_app/app/modules/notifications/widgets/NameCard.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with TickerProviderStateMixin {
  bool pressGeoON = false;
  bool cmbscritta = false;
  final CollectionReference connectCollection =
      FirebaseFirestore.instance.collection('connect');
  List friendRequest = [];
  late TextEditingController _controller;
  late TabController _tabController;
  final NotificationsController notifycationsCtrl =
      Get.find<NotificationsController>();
  final ConnectController connectCtrl = Get.find<ConnectController>();
  final SignInController signInCtrl = Get.find<SignInController>();
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
  }

  void getData() async {
    DocumentSnapshot snap =
        await connectCollection.doc(signInCtrl.userId.value).get();
    if (snap.data() != null) {
      friendRequest = (snap.data()! as dynamic)['friendRequest'];
    } else {
      friendRequest = [];
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
      new Duration(seconds: 1),
      (timer) {
        List temp = notifycationsCtrl.friendRequest;
        getData();
        if (temp.length != friendRequest.length) {
          notifycationsCtrl.updateFriendRequest(friendRequest);
        }
      },
    );
    Timer.periodic(
      new Duration(seconds: 1),
      (timer) {
        helpDialog(signInCtrl.userId.value);
      },
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                SizedBox(height: 35),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.home);
                      },
                      child: Image.asset(
                        'assets/images/left-small.png',
                        width: 28,
                      ),
                    ),
                    SizedBox(width: 22.5),
                    Text(
                      'Notifications',
                      style: CustomTextStyle.h1(AppColors.black),
                    ),
                  ],
                ),
                SizedBox(height: 29),
                Container(
                  child: Image.asset('assets/images/notification_img.png',
                  fit: BoxFit.contain),
                  width: 400,
                  height: 126,
                ),
                SizedBox(height: 16),
                Container(
                  height: 0.1,
                  width: 378.5,
                  color: AppColors.black,
                ),
                // SizedBox(height: 30),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: TabBar(
                          unselectedLabelStyle: CustomTextStyle.button(AppColors.primaryColor),
                          indicator: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(50), // Creates border
                            color: AppColors.primaryColor,
                          ),
                          labelStyle: CustomTextStyle.button(AppColors.white),
                          labelPadding: EdgeInsets.all(14),
                          // padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.primaryColor,
                          controller: _tabController,
                          tabs: [
                            Text('Diary'),
                            Stack(
                              children: [
                                Text('Friend'),
                                Container(
                                  margin: EdgeInsets.fromLTRB(60, 2, 0, 0),
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors
                                          .notificationBackgroundColor),
                                  child: (Text(
                                    '1',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Montserrat',
                                      color: AppColors.white,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 300,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                              itemCount: 2,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (_, index) {
                                return Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 56.0),
                                    title: Text(
                                      'Chat',
                                      style: CustomTextStyle.h2(AppColors.black),
                                    ),
                                    subtitle: Text(
                                      'Today',
                                      style: CustomTextStyle.small_desc(AppColors.blur),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Obx(
                              () => ListView.builder(
                                itemCount:
                                    notifycationsCtrl.friendRequest.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, _index) {
                                  return NameCard(index: _index);
                                },
                              ),
                            )
                          ],
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
