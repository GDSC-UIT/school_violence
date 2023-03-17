import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/data/services/emergency.dart';
import 'package:school_violence_app/app/global_widgets/bottom_navigation.dart';
import 'package:school_violence_app/app/global_widgets/help_dialog.dart';
import 'package:school_violence_app/app/modules/home_page/widgets/emergency_dialog.dart';
import 'package:school_violence_app/app/modules/home_page/widgets/name.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller;
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
    if (snap.data() != null)
      _friends = (snap.data()! as dynamic)['friends'];
    else
      _friends = [];
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
      new Duration(seconds: 1),
      (timer) {
        helpDialog(signInCtrl.userId.value);
      },
    );
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        onItem: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendHelp();
          Get.toNamed(AppRoutes.map);
        },
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

              Name(),
              SizedBox(height: 32),
              Image.asset('assets/images/home_img.png',
                  width: 400, height: 170, fit: BoxFit.fill),
            ],
          ),
        ),
      ),
    );
  }
}
