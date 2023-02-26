import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';
import 'package:school_violence_app/app/modules/notifications/widgets/NameCard.dart';
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
  late TextEditingController _controller;
  late TabController _tabController;
  final NotificationsController notifycationsCtrl =
      Get.find<NotificationsController>();

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
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Montserrat',
                        color: AppColors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 29),
                Image.asset('assets/images/grey-rectangle.png'),
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
                          unselectedLabelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          indicator: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(50), // Creates border
                            color: AppColors.primaryColor,
                          ),
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
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
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Montserrat',
                                        color: AppColors.black,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Today',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Montserrat',
                                        color: AppColors.blur,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500,
                                      ),
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
