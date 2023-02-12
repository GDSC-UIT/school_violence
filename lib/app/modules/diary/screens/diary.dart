import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/global_widgets/bottom_navigation.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/email.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';
import '../diary_controller.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage({super.key});
  
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> with TickerProviderStateMixin {
  bool pressGeoON = false;
  bool cmbscritta = false;
  late TabController _tabController;
  TextEditingController mess_controller = TextEditingController();
  late bool have_text =false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    mess_controller.addListener(() { setState(()=>have_text = mess_controller.text.isNotEmpty && mess_controller.text!=""); });
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
        bottomNavigationBar: BottomNavigation(
          onItem: 1,
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
                          tabs: [Text('Chat'), Text('AI')],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.maxFinite,
                        height: 270,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            SizedBox(
                              width: 240, // <-- TextField width
                              height: 120, // <-- TextField height
                              child: TextField(
                                controller: mess_controller,
                                maxLines: null,
                                expands: true,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  filled: true,
                                  hintText: 'Enter a message',
                                ),
                              ),
                            ),
                            const SizedBox(
                              child: TextField(
                                maxLines: null,
                                expands: true,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Enter a message',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.chatroom);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: have_text?AppColors.primaryColor:AppColors.grey,
                          shadowColor: have_text?AppColors.primaryColorShadow:AppColors.grey,
                          elevation: 5,
                          minimumSize: const Size(382, 54),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: Text(
                          'Start',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: have_text?AppColors.white:Color(0xFF898989),
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
