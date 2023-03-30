import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/data/services/emergency.dart';

import 'package:school_violence_app/app/global_widgets/bottom_navigation.dart';
import 'package:school_violence_app/app/modules/diary/screens/chatscreen.dart';
import 'package:school_violence_app/app/modules/diary/widgets/ChatList.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';
import '../../../core/values/app_text_style.dart';
import '../diary_controller.dart';
import 'dart:math';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> with TickerProviderStateMixin {
  bool pressGeoON = false;
  bool cmbscritta = false;
  late TabController _tabController;
  TextEditingController mess_controller = TextEditingController();

  final DiaryController ctrlDiary = Get.find<DiaryController>();
  final SignInController signInCtrl = Get.find<SignInController>();
  final Connect _connect = Connect();
  final Emergency _emergency = Emergency();
  List _friends = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    mess_controller.addListener(() {
      ctrlDiary.haveText.value =
          mess_controller.text.isNotEmpty && mess_controller.text != "";
    });
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

  Future<bool> isExpert() async {
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(signInCtrl.userId.value)
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
    getData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigation(
          onItem: 1,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            sendHelp();
            Get.toNamed(AppRoutes.map);
          },
          child: Image.asset('assets/icons/map_icon.png'),
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
                      'assets/images/logo-protected.png',
                      width: 50,
                    ),
                    const SizedBox(width: 22.5),
                    Text(
                      'Chat with Expert',
                      style: CustomTextStyle.h1(AppColors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 29),
                SizedBox(
                  width: 400,
                  height: 120,
                  child: Image.asset('assets/images/diary_img.png',
                      fit: BoxFit.contain),
                ),
                const SizedBox(height: 16),

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
                          return const ChatList();
                        } else {
                          return SizedBox(
                            height: 400,
                            child: ListView(children: [
                              const ChatList(),
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
                                        unselectedLabelStyle:
                                            CustomTextStyle.button(
                                                AppColors.primaryColor),
                                        indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              50), // Creates border
                                          color: AppColors.primaryColor,
                                        ),
                                        labelStyle: CustomTextStyle.button(
                                            AppColors.white),
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
                                    SizedBox(
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
                                              decoration: InputDecoration(
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.primaryColor,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
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
                                    const SizedBox(height: 20),
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
                                                Timer timer = Timer(
                                                    const Duration(seconds: 5),
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
                                                        signInCtrl.userId.value,
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
                                                        signInCtrl.userId.value,
                                                        expert[randomExpert].id
                                                      ],
                                                    });
                                                    Get.to(() => ChatScreen(
                                                          initial_text:
                                                              mess_controller
                                                                  .text,
                                                          roomUser: [
                                                            signInCtrl
                                                                .userId.value,
                                                            expert[randomExpert]
                                                                .id
                                                          ],
                                                          nowUser: signInCtrl
                                                              .userId.value,
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
                                                            : const Color(
                                                                0xFF898989),
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
                                    const SizedBox(height: 20),
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
