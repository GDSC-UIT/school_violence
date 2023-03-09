import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_violence_app/app/data/services/database.dart';
import 'package:school_violence_app/app/global_widgets/help_dialog.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(10.875407, 106.807905), zoom: 14.0);

  final SignInController signInCtrl = Get.find<SignInController>();

  Set<Marker> markers = {};

  Future<Position> _determinePositon() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

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
        title: const Text('User current location'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePositon();
          await googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14),
            ),
          );
          await DatabaseService(uid: signInCtrl.userId.value).updateUserData(
            signInCtrl.userId.value,
            signInCtrl.userName.value,
            signInCtrl.email.value,
            signInCtrl.password.value,
            signInCtrl.fullName.value,
            signInCtrl.dateOfBirth.value,
            signInCtrl.phoneNumber.value,
            signInCtrl.country.value,
            signInCtrl.province.value,
            signInCtrl.city.value,
            signInCtrl.school.value,
            signInCtrl.expert.value,
            position.latitude,
            position.longitude,
          );
          markers.clear();
          markers.add(
            Marker(
              markerId: const MarkerId('Current Location'),
              position: LatLng(position.latitude, position.longitude),
            ),
          );
          setState(() {});
        },
        label: Text("Current location"),
        icon: Icon(Icons.location_history),
      ),
    );
  }
}
