import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/map/widgets/bottm_sheet_content.dart';
import 'package:school_violence_app/app/modules/map/widgets/current_location_icon.dart';
import 'package:school_violence_app/app/modules/map/widgets/welcome_banner.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import '../widgets/notification_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:background_sms/background_sms.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SignInController signInCtrl = Get.find<SignInController>();
  final Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;
  final List<Marker> _marker = <Marker>[];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((currentPosition) {})
        .onError((error, stackTrace) {
      print("Error: " + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  void loadData() {
    getUserCurrentLocation().then(
      (currentPosition) async {
        _marker.add(
          Marker(
            markerId: MarkerId(''),
            position:
                LatLng(currentPosition.latitude, currentPosition.longitude),
            infoWindow: InfoWindow(title: "Here!!!"),
          ),
        );
        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 15,
        );
        final GoogleMapController controller = await _controller.future;
        _currentPosition = currentPosition;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {});
      },
    );
  }

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: simSlot,
    ).then((SmsStatus status) {
      if (status == "sent") {
        print("sent");
      } else {
        print("failed");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
  }

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(
    //   new Duration(milliseconds: 100),
    //   (timer) {
    //     if (Get.isDialogOpen == false) {
    //       helpDialog(signInCtrl.userId.value);
    //     }
    //   },
    // );
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(10.870565, 106.802795), zoom: 14.5),
              mapType: MapType.normal,
              markers: Set<Marker>.of(_marker),
              zoomControlsEnabled: false,
            ),
          ),
          Positioned(
            top: 60,
            right: 20,
            left: 20,
            child: Container(
              width: Get.width,
              child: WelcomeBanner(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 8),
              child: GestureDetector(
                onTap: () async {
                  loadData();
                  Get.bottomSheet(BottomSheetContent());
                },
                child: CurrentLocationButton(),
              ),
            ),
          ),
          notificationButton(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width * 0.8,
              height: 25,
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.05),
                    spreadRadius: 4,
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Container(
                  width: Get.width * 0.4,
                  height: 4,
                  color: Colors.black45,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
