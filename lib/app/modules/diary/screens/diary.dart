import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

import 'package:school_violence_app/app/core/values/app_text_style.dart';

import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/global_widgets/bottom_navigation.dart';
import 'package:school_violence_app/app/modules/diary/screens/chatscreen.dart';
import 'package:school_violence_app/app/modules/diary/widgets/ChatList.dart';
import 'package:school_violence_app/app/modules/forgot_passwords/screens/email.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';
import '../../connect/connect_controller.dart';
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
  final SignInController ctrl = Get.find<SignInController>();
  late bool have_text = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    mess_controller.addListener(() {
      // setState(() => have_text =
      //     mess_controller.text.isNotEmpty && mess_controller.text != "");
    });
  }

  Future<bool> isExpert() async {
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(ctrl.userId.value)
        .get();
    return user.data()!['expert'];
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
                const SizedBox(height: 35),

                Row(
                  children: [
                    Image.asset(
                      'assets/images/left-small.png',
                      width: 28,
                    ),
                    const SizedBox(width: 22.5),
                    const Text(
                      'Diary',
                      style: CustomTextStyle.h1(AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 29),
                Image.asset('assets/images/grey-rectangle.png'),
                const SizedBox(height: 16),
                Container(
                  height: 0.1,
                  width: 378.5,
                  color: AppColors.black,
                ),

                FutureBuilder<bool>(
                    future: isExpert(), // a Future<String> or null
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        );
                      } else {
                        if (snapshot.data == true) {
                          return ChatList();
                        } else {
                          return SizedBox(
                            height: 400,
                            child: ListView(children: [
                              ChatList(),
                              DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: TabBar(
                                        unselectedLabelStyle: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                        indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              50), // Creates border
                                          color: AppColors.primaryColor,
                                        ),
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        labelPadding: const EdgeInsets.all(14),
                                        // padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
                                        labelColor: AppColors.white,
                                        unselectedLabelColor:
                                            AppColors.primaryColor,
                                        controller: _tabController,
                                        tabs: const [Text('Chat'), Text('AI')],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                              keyboardType:
                                                  TextInputType.multiline,
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
                                              keyboardType:
                                                  TextInputType.multiline,
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
                                      onPressed: () async {
                                        if (!have_text) {
                                          var fetchExpert =
                                              await FirebaseFirestore
                                                  .instance
                                                  .collection('users')
                                                  .where('expert',
                                                      isEqualTo: true)
                                                  .get();
                                          var expert = fetchExpert.docs
                                              .map((e) =>
                                                  Expert.fromJson(e.data()))
                                              .toList();

                                          var a = await FirebaseFirestore
                                              .instance
                                              .collection("room")
                                              .where("roomUser", isEqualTo: [
                                            ctrl.userId.value,
                                            expert.single.id
                                          ]).get();
                                          if (a.docs.isEmpty) {
                                            await FirebaseFirestore.instance
                                                .collection("room")
                                                .add({
                                              "roomUser": [
                                                ctrl.userId.value,
                                                expert.single.id
                                              ],
                                            });
                                            Get.to(() => ChatScreen(
                                                  initial_text:
                                                      mess_controller.text,
                                                  roomUser: [
                                                    ctrl.userId.value,
                                                    expert.single.id
                                                  ],
                                                  nowUser: ctrl.userId.value,
                                                ));
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: have_text
                                            ? AppColors.primaryColor
                                            : AppColors.grey,
                                        shadowColor: have_text
                                            ? AppColors.primaryColorShadow
                                            : AppColors.grey,
                                        elevation: 5,
                                        minimumSize: const Size(382, 54),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                      ),
                                      child: Text(
                                        'Start',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: have_text
                                              ? AppColors.white
                                              : Color(0xFF898989),
                                          fontSize: 16,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          );
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Expert {
  final String id;
  final String userName;
  final String email;
  final String password;
  final String fullName;
  final String dateOfBirth;
  final String phoneNumber;
  final String country;
  final String province;
  final String city;
  final String school;
  final bool expert;
  Expert({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.fullName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.country,
    required this.province,
    required this.city,
    required this.school,
    required this.expert,
  });
  static Expert fromJson(Map<String, dynamic> json) => Expert(
      id: json["id"],
      userName: json["userName"],
      email: json["email"],
      password: json["password"],
      fullName: json["fullName"],
      dateOfBirth: json["dateOfBirth"],
      phoneNumber: json["phoneNumber"],
      country: json["country"],
      province: json["province"],
      city: json["city"],
      school: json["school"],
      expert: json["expert"]);
}
