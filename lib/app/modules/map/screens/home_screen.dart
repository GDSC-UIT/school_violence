import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/global_widgets/help_dialog.dart';
import 'package:school_violence_app/app/modules/map/screens/live_tracking_location.dart';
import 'package:school_violence_app/app/modules/map/screens/simple_map_screen.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'current_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SignInController signInCtrl = Get.find<SignInController>();
  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      new Duration(seconds: 1),
      (timer) {
        helpDialog(signInCtrl.userId.value);
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Google Map'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const SimpleMapScreen();
                }));
              },
              child: const Text('Simple Map'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const CurrentLocationScreen();
                }));
              },
              child: const Text('User current location'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const LiveTrackingScreen();
                }));
              },
              child: const Text('Live tracking'),
            )
          ],
        ),
      ),
    );
  }
}
