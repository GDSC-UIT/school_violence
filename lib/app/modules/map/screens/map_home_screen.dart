import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/map/widgets/bottom_sheet_content.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import '../map_controller.dart';
import '../widgets/guide_button.dart';
import '../widgets/welcome_banner.dart';

enum TypeBullyEnum { violence, shooting }

String googleApiKey = 'AIzaSyDp9al2OngJ2669NU0cJOyRNm4eQP6sguA';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  //Controller
  final SignInController signInCtrl = Get.find<SignInController>();

  final TextEditingController _messageController = TextEditingController();
  final mapController = Get.put(MapController());

  TypeBullyEnum? _typeBullyEnum;
  TypeBullyEnum? newTypeBully;

  //Debounce to throttle async calls during search

  bool getDirections = false;

  // Set<Marker> _markersDupe = Set<Marker>();

  List<LatLng> _latLng = [];

  late Marker endMarker;

  double distanceInMeters = 0.0;

  // var tappedPoint;

  //Circle

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((currentPosition) {})
        .onError((error, stackTrace) {
      print("Error: $error");
    });
    return await Geolocator.getCurrentPosition();
  }

  void loadData() {
    getUserCurrentLocation().then(
      (currentPosition) async {
        mapController.markers.add(
          Marker(
            markerId: const MarkerId(''),
            position:
                LatLng(currentPosition.latitude, currentPosition.longitude),
            infoWindow: const InfoWindow(title: "Here!!!"),
          ),
        );
        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 17,
        );
        mapController.currentPositon =
            LatLng(currentPosition.latitude, currentPosition.longitude);
        final GoogleMapController controller =
            await mapController.googleMapController.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {
          mapController.startMarker = Marker(
            markerId: const MarkerId('start'),
            position: LatLng(
              currentPosition.latitude,
              currentPosition.longitude,
            ),
          );
        });
      },
    );
  }

  void _addEndMarker(LatLng position) {
    setState(() {
      endMarker = Marker(
        markerId: const MarkerId('end'),
        position: position,
      );
      _latLng.add(endMarker.position);
    });
  }

  @override
  void initState() {
    super.initState();
    // _getPermission();
    loadData();
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
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(() => GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController.googleMapController.complete(controller);
                  },
                  initialCameraPosition: const CameraPosition(
                      target: LatLng(10.870565, 106.802795), zoom: 17),
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(mapController.markers),
                  polylines: Set<Polyline>.of(mapController.polylines),
                  zoomControlsEnabled: false,
                  circles: mapController.circles,
                )),
          ),
          Positioned(
            top: 40,
            right: 20,
            left: 20,
            child: SizedBox(
              width: Get.width,
              child: GestureDetector(
                onTap: () => setState(() {}),
                child: const WelcomeBanner(),
              ),
            ),
          ),
          Obx(
            () => mapController.alertButton.value
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30, right: 8),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            loadData();
                            print(mapController.polylines);
                          });
                          _latLng = [];
                          mapController.polylines.clear();
                          await Get.bottomSheet(const BottomSheetContent());
                          setState(() {});
                        },
                        child: const Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(
                              Icons.notification_important,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ),
          mapController.guideButton.value ? const GuideButton() : Container(),
          mapController.bottomSheetStatus.value
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: Get.width,
                    height: 122,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.05),
                          spreadRadius: 4,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            mapController.circles.clear();
                            mapController.markers.clear();
                            mapController.minDistance = 0.0;
                            mapController.allFavoritePlaces.clear();
                            _latLng = [];
                            mapController.polylines.clear();
                            mapController.markerIdCounter = 1;
                            mapController.closeButton.value = false;
                            mapController.alertButton.value = true;
                            mapController.guideButton.value = true;
                            mapController.bottomSheetStatus.value = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          backgroundColor:
                              AppColors.notificationBackgroundColor,
                          elevation: 0,
                          minimumSize: const Size(380, 50),
                        ),
                        child: const Text(
                          'Stop',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
