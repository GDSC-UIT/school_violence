import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/database.dart';
import 'package:school_violence_app/app/modules/map/map_controller.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  MapController _controller = MapController();
  final SignInController signInCtrl = Get.find<SignInController>();
  Location location = Location();
  LocationData? currentLocation;

  Set<Marker> markers = Set<Marker>();
  late BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/location-pin.png');
  }

  void getCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();
      _controller.updateLatitude(currentLocation!.latitude!);
      _controller.updateLongtitude(currentLocation!.longitude!);
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
        _controller.latitude.value,
        _controller.longtitude.value,
      );
      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId("My Location"),
            position: LatLng(
                _controller.latitude.value, _controller.longtitude.value),
            icon: pinLocationIcon,
          ),
        );
      });
    } catch (e) {
      print('ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Map'),
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.home);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.black,
            ),
          ),
        ),
        body: Obx(
          () => GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  _controller.latitude.value, _controller.longtitude.value),
              zoom: 10.0,
            ),
            myLocationEnabled: true,
            markers: markers,
          ),
        ),
      ),
    );
  }
}
