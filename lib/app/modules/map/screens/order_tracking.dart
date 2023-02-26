import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Location location = Location();
  LocationData? currentLocation;

  Set<Marker> markers = Set<Marker>();
  late BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();
    // getCurrentLocation();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/location-pin.png');
  }

  // void getCurrentLocation() async {
  //   try {
  //     currentLocation = await location.getLocation();
  //     setState(() {
  //       markers.add(
  //         Marker(
  //           markerId: MarkerId("My Location"),
  //           position:
  //               LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
  //           icon: pinLocationIcon,
  //         ),
  //       );
  //     });
  //   } catch (e) {
  //     print('ERROR: $e');
  //   }
  // }

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
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(37.4220, -122.0841),
            zoom: 10.0,
          ),
          myLocationEnabled: true,
          markers: markers,
        ),
      ),
    );
  }
}
