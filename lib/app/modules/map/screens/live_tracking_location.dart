import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:school_violence_app/app/global_widgets/help_dialog.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

const String googleApiKey = 'AIzaSyCoXGfVTIF9Kv6xFuJ85tB3ZwZdFevU2V8';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  late GoogleMapController googleMapController;
  late StreamSubscription<Position> positionStream;

  static const LatLng sourceLocation = LatLng(10.875407, 106.807905);
  static const LatLng destination = LatLng(10.8799879, 106.8108467);
  final SignInController signInCtrl = Get.find<SignInController>();

  List<LatLng> polylineCoordinates = [];

  Position? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

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

  void getCurrentLocation() async {
    currentLocation = await _determinePositon();

    Geolocator.getPositionStream().listen(
      (Position newLoc) {
        // Do something with the position data
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 14.0,
              target: LatLng(
                newLoc.latitude,
                newLoc.longitude,
              ),
            ),
          ),
        );
        // setState(() {});
      },
    );
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
    }
    setState(() {});
  }

  void setCutomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/key.png')
        .then(
      (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/lock.png')
        .then(
      (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/mail.png')
        .then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  @override
  void initState() {
    // getCurrentLocation();
    setCutomMarkerIcon();

    super.initState();
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
      body: FutureBuilder(
        future: _determinePositon(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            currentLocation = snapshot.data;
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude, currentLocation!.longitude),
                zoom: 14.0,
              ),
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: polylineCoordinates,
                  color: AppColors.primaryColor,
                  width: 6,
                ),
              },
              markers: {
                Marker(
                  markerId: const MarkerId("source"),
                  position: sourceLocation,
                  icon: sourceIcon,
                ),
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(
                      currentLocation!.latitude, currentLocation!.longitude),
                  icon: currentLocationIcon,
                ),
                Marker(
                  markerId: const MarkerId("destination"),
                  position: destination,
                  icon: destinationIcon,
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
                getCurrentLocation();
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          getPolyPoints();
        },
        label: Text("test "),
        icon: Icon(Icons.location_history),
      ),
    );
  }
}
