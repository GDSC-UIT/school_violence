import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

import 'package:school_violence_app/app/global_widgets/bottom_navigation.dart';
import 'package:school_violence_app/app/modules/diary/screens/chatscreen.dart';
import 'package:school_violence_app/app/modules/diary/widgets/ChatList.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import '../../../core/values/app_text_style.dart';
import '../diary_controller.dart';
import 'dart:math';

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
  final DiaryController ctrlDiary = Get.find<DiaryController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    mess_controller.addListener(() {
      ctrlDiary.haveText.value =
          mess_controller.text.isNotEmpty && mess_controller.text != "";
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
                    Text(
                      'Diary',
                      style: CustomTextStyle.h1(AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 29),
                Container(
                  child: Image.asset('assets/images/diary_img.png',
                  fit: BoxFit.contain),
                  width: 400,
                  height: 120,
                ),
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
                                        unselectedLabelStyle: CustomTextStyle.button(AppColors.primaryColor),
                                        indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              50), // Creates border
                                          color: AppColors.primaryColor,
                                        ),
                                        labelStyle: CustomTextStyle.button(AppColors.white),
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
                                    Obx(() => (ElevatedButton(
                                          onPressed: () async {
                                            if (ctrlDiary.haveText.value) {
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
                                              if (expert.isNotEmpty) {
                                                ctrlDiary.isFetchingExpert
                                                    .value = true;
                                                Random rng = Random();
                                                Timer _timer = Timer(
                                                    Duration(seconds: 5),
                                                    () => {
                                                          if (ctrlDiary
                                                              .isFetchingExpert
                                                              .value)
                                                            {
                                                              ctrlDiary
                                                                  .isFetchingExpert
                                                                  .value = false,
                                                              Get.defaultDialog(
                                                                title:
                                                                    "Please try again later ...",
                                                                content:
                                                                    const Text(
                                                                  'There is no more expert online now',
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    child:
                                                                        const Text(
                                                                      "Close",
                                                                      style: TextStyle(
                                                                          color:
                                                                              AppColors.primaryColor),
                                                                    ),
                                                                    onPressed:
                                                                        () => Get
                                                                            .back(),
                                                                  ),
                                                                ],
                                                              )
                                                            }
                                                        });
                                                while (ctrlDiary
                                                    .isFetchingExpert.value) {
                                                  var randomExpert = rng
                                                      .nextInt(expert.length);
                                                  var oldExpert =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("room")
                                                          .where("roomUser",
                                                              isEqualTo: [
                                                        ctrl.userId.value,
                                                        expert[randomExpert].id
                                                      ]).get();
                                                  if (oldExpert.docs.isEmpty) {
                                                    ctrlDiary.isFetchingExpert
                                                        .value = false;
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("room")
                                                        .add({
                                                      "roomUser": [
                                                        ctrl.userId.value,
                                                        expert[randomExpert].id
                                                      ],
                                                    });
                                                    Get.to(() => ChatScreen(
                                                          initial_text:
                                                              mess_controller
                                                                  .text,
                                                          roomUser: [
                                                            ctrl.userId.value,
                                                            expert[randomExpert]
                                                                .id
                                                          ],
                                                          nowUser:
                                                              ctrl.userId.value,
                                                        ));
                                                  }
                                                }
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ctrlDiary.haveText.value
                                                    ? AppColors.primaryColor
                                                    : AppColors.grey,
                                            shadowColor: ctrlDiary
                                                    .haveText.value
                                                ? AppColors.primaryColorShadow
                                                : AppColors.grey,
                                            elevation: 5,
                                            minimumSize: const Size(382, 54),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              !ctrlDiary.isFetchingExpert.value
                                                  ? Text(
                                                      'Start',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: ctrlDiary
                                                                .haveText.value
                                                            ? AppColors.white
                                                            : Color(0xFF898989),
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  : const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: AppColors.grey,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ))),
                                    SizedBox(height: 20),
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
