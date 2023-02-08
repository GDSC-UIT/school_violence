import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/email.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> with TickerProviderStateMixin {
  bool pressGeoON = false;
  bool cmbscritta = false;
  late TextEditingController _controller;
  late TabController _tabController;

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
                    Image.asset(
                      'assets/images/left-small.png',
                      width: 28,
                    ),
                    SizedBox(width: 22.5),
                    Text(
                      'Diary',
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
                          padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.secondaryColorShadow,
                          controller: _tabController,
                          tabs: [Text('Chat'), Text('AI')],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.maxFinite,
                        height: 200,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            SizedBox(
                              child: TextField(
                                maxLines: null,
                                expands: true,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    filled: true, hintText: 'Enter a message'),
                              ),
                            ),
                            SizedBox(
                              child: TextField(
                                maxLines: null,
                                expands: true,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    filled: true, hintText: 'Enter a message'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 70),
                      ElevatedButton(
                        onPressed: () {
                          // Get.to(EmailPage());
                        },
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
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
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
