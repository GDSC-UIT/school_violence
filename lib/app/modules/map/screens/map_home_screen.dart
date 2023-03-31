import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/map/widgets/bottom_sheet_content.dart';
import 'package:school_violence_app/app/modules/map/widgets/welcome_banner.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';
import '../services/map_service.dart';
import '../services/polyline_service.dart';
import '../widgets/guide_button.dart';

enum TypeBullyEnum { violence, shooting }

String googleApiKey = 'AIzaSyDp9al2OngJ2669NU0cJOyRNm4eQP6sguA';

late LatLng _currentPositon;

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  //Controller
  final SignInController signInCtrl = Get.find<SignInController>();
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _messageController = TextEditingController();

  TypeBullyEnum? _typeBullyEnum;
  TypeBullyEnum? newTypeBully;

  //Debounce to throttle async calls during search
  Timer? _debounce;

  //Toggling UI as we need;
  bool radiusSlider = false;
  bool getDirections = false;
  bool closeButton = false;
  bool guideButton = true;
  bool alertButton = true;
  bool bottomSheetStatus = false;

  //Markers set
  Set<Marker> _markers = Set<Marker>();
  // Set<Marker> _markersDupe = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> _latLng = [];

  int markerIdCounter = 1;

  late Marker startMarker;
  late Marker endMarker;
  late Polyline polyline;
  double distanceInMeters = 0.0;
  double minDistance = 0.0;
  double totalDistance = 0.0;

  var radiusValue = 400.0;

  // var tappedPoint;

  List allFavoritePlaces = [];

  String tokenKey = '';

  //Circle
  Set<Circle> _circles = Set<Circle>();

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
        _markers.add(
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
        _currentPositon =
            LatLng(currentPosition.latitude, currentPosition.longitude);
        final GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {
          startMarker = Marker(
            markerId: MarkerId('start'),
            position: LatLng(
              currentPosition.latitude,
              currentPosition.longitude,
            ),
          );
        });
      },
    );
  }

  void _setCircle(LatLng point) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: 17,
        ),
      ),
    );
    setState(() {
      _circles.add(
        Circle(
          circleId: CircleId('raj'),
          center: point,
          fillColor: AppColors.primaryColor.withOpacity(0.1),
          radius: radiusValue,
          strokeColor: AppColors.primaryColor,
          strokeWidth: 1,
        ),
      );
      radiusSlider = true;
    });
  }

  //Custom Marker
  void _setNearMarker(
      LatLng point, String label, List types, String status) async {
    var counter = markerIdCounter++;

    final Uint8List markerIcon;

    if (types.contains('restaurants'))
      markerIcon =
          await getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    else if (types.contains('food'))
      markerIcon = await getBytesFromAsset('assets/mapicons/food.png', 75);
    else if (types.contains('school'))
      markerIcon = await getBytesFromAsset('assets/mapicons/schools.png', 75);
    else if (types.contains('bar'))
      markerIcon = await getBytesFromAsset('assets/mapicons/bars.png', 75);
    else if (types.contains('lodging'))
      markerIcon = await getBytesFromAsset('assets/mapicons/hotels.png', 75);
    else if (types.contains('store'))
      markerIcon =
          await getBytesFromAsset('assets/mapicons/retail-stores.png', 75);
    else if (types.contains('locality'))
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    else
      markerIcon = await getBytesFromAsset('assets/mapicons/places.png', 75);

    final Marker marker = Marker(
      markerId: MarkerId('marker_$counter'),
      infoWindow: InfoWindow(title: label),
      position: point,
      onTap: () {},
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    _drawPolyline(startMarker.position, marker.position);

    setState(() {
      _markers.add(marker);
    });
  }

  void _addEndMarker(LatLng position) {
    setState(() {
      endMarker = Marker(
        markerId: MarkerId('end'),
        position: position,
      );
      _latLng.add(endMarker.position);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _drawPolyline(LatLng from, LatLng to) async {
    polyline = await drawPolyline(from, to);
    if (minDistance == 0) {
      minDistance = totalDistance;
      _polylines.add(polyline);
    } else {
      if (totalDistance < minDistance) {
        minDistance = totalDistance;
        _polylines = {};
        _polylines.add(polyline);
        setState(() {});
      }
    }
  }

  Future<Polyline> drawPolyline(LatLng from, LatLng to) async {
    List<LatLng> polylineCoordinates = [];

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(from.latitude, from.longitude),
        PointLatLng(to.latitude, to.longitude));

    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
    _calculateDistance(polylineCoordinates);
    return Polyline(
      polylineId: PolylineId("polyline_id ${result.points.length}"),
      color: AppColors.primaryColor,
      points: polylineCoordinates,
      width: 3,
    );
  }

  void _calculateDistance(List<LatLng> polylineCoordinates) async {
    totalDistance = 0.0;
    // Calculating the total distance by adding the distance
    // between small segments
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    print(minDistance.toStringAsFixed(2));
    print("distance = ${totalDistance.toStringAsFixed(2)} km");
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
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
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: const CameraPosition(
                  target: LatLng(10.870565, 106.802795), zoom: 17),
              mapType: MapType.normal,
              markers: _markers,
              polylines: _polylines,
              zoomControlsEnabled: false,
              circles: _circles,
              // onTap: (point) {
              //   tappedPoint = point;
              //   setState(() {
              //     _setCircle(point);
              //   });
              // },
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            left: 20,
            child: SizedBox(
              width: Get.width,
              child: const WelcomeBanner(),
            ),
          ),
          alertButton
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30, right: 8),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          loadData();
                          print(_polylines);
                        });
                        _latLng = [];
                        _polylines = {};
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                width: Get.width,
                                height: Get.height * 0.5,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(36),
                                    topRight: Radius.circular(36),
                                  ),
                                  color: AppColors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Center(
                                      child: Container(
                                        width: Get.width * 0.10,
                                        height: 4,
                                        color: Colors.black26,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Icon(
                                          Icons.notification_important,
                                          color: AppColors.primaryColor,
                                          size: 64,
                                        ),
                                      ),
                                    ),
                                    Form(
                                      child: Column(
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Message",
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            validator: null,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _messageController.text =
                                                    newValue;
                                              });
                                            },
                                            initialValue:
                                                _messageController.text,
                                            decoration: InputDecoration(
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                  color: AppColors.transparent,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                              hintStyle: const TextStyle(
                                                color: AppColors.primaryColor,
                                              ),
                                              label: const Text(
                                                "Type a message to report (optional)",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Type",
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: TypeBullyEnum.violence,
                                                groupValue: _typeBullyEnum,
                                                onChanged: (newTypeBully) {
                                                  setState(() {
                                                    _typeBullyEnum =
                                                        newTypeBully;
                                                  });
                                                },
                                                activeColor:
                                                    AppColors.primaryColor,
                                              ),
                                              const SizedBox(
                                                width: 2.0,
                                              ),
                                              const Text("Violence"),
                                              const SizedBox(
                                                width: 80,
                                              ),
                                              Radio(
                                                value: TypeBullyEnum.shooting,
                                                groupValue: _typeBullyEnum,
                                                onChanged: (newTypeBully) {
                                                  setState(() {
                                                    _typeBullyEnum =
                                                        newTypeBully;
                                                  });
                                                },
                                                activeColor:
                                                    AppColors.primaryColor,
                                              ),
                                              const SizedBox(
                                                width: 2.0,
                                              ),
                                              const Text("School Shooting"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      color: AppColors.grey,
                                      height: 1.0,
                                      width: double.infinity,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        alertButton = false;
                                        guideButton = false;
                                        bottomSheetStatus = true;
                                        if (_typeBullyEnum ==
                                            TypeBullyEnum.violence) {
                                          setState(() {
                                            closeButton = true;
                                            _setCircle(_currentPositon);
                                          });
                                          if (_debounce?.isActive ?? false)
                                            _debounce?.cancel();
                                          _debounce = Timer(
                                            Duration(seconds: 1),
                                            () async {
                                              var placesResult =
                                                  await MapServices()
                                                      .getPlaceDetails(
                                                          _currentPositon,
                                                          radiusValue.toInt());

                                              List<dynamic> placesWithin =
                                                  placesResult['results']
                                                      as List;

                                              allFavoritePlaces = placesWithin;

                                              tokenKey = placesResult[
                                                      'next_page_token'] ??
                                                  'none';

                                              placesWithin.forEach((element) {
                                                if (element['opening_hours'] !=
                                                    null) {
                                                  _setNearMarker(
                                                    LatLng(
                                                      element['geometry']
                                                          ['location']['lat'],
                                                      element['geometry']
                                                          ['location']['lng'],
                                                    ),
                                                    element['name'],
                                                    element['types'],
                                                    element['business_status'] ??
                                                        'not available',
                                                  );
                                                }
                                              });
                                              // _markersDupe = _markers;
                                            },
                                          );
                                          // _drawPolyline(startMarker.position,
                                          //     endMarker.position);
                                        } else if (_typeBullyEnum ==
                                            TypeBullyEnum.shooting) {
                                          print('shooting');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        backgroundColor: AppColors.primaryColor,
                                        elevation: 0,
                                        minimumSize: const Size(380, 50),
                                      ),
                                      child: const Text(
                                        "Start",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
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
          guideButton ? const GuideButton() : Container(),
          bottomSheetStatus
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
                            _circles = {};
                            _markers = {};
                            minDistance = 0.0;
                            allFavoritePlaces = [];
                            _latLng = [];
                            _polylines = {};
                            markerIdCounter = 1;
                            closeButton = false;
                            alertButton = true;
                            guideButton = true;
                            bottomSheetStatus = false;
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
