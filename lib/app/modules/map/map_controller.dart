import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_violence_app/app/modules/map/screens/map_home_screen.dart';

import '../../core/values/app_colors.dart';

class MapController extends GetxController {
  RxInt selectedIndex = 0.obs;

  //Toggling UI as we need;
  bool radiusSlider = false;
  Rx<bool> guideButton = true.obs;
  Rx<bool> alertButton = true.obs;
  Rx<bool> bottomSheetStatus = false.obs;
  Rx<bool> closeButton = false.obs;

  var radiusValue = 400.0;
  int markerIdCounter = 1;
  double totalDistance = 0.0;
  double minDistance = 0.0;

  String tokenKey = '';

  Timer? debounce;
  late Polyline polyline;
  late Marker startMarker;

  RxSet<Circle> circles = <Circle>{}.obs;
  RxList allFavoritePlaces = [].obs;
  //Markers set
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;

  final Completer<GoogleMapController> googleMapController = Completer();

  late LatLng currentPositon;

  void updateSelectedIndex(int id) {
    selectedIndex.value = id;
  }

  void setCircle(LatLng point) async {
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: 17,
        ),
      ),
    );
    circles.add(
      Circle(
        circleId: const CircleId('raj'),
        center: point,
        fillColor: AppColors.primaryColor.withOpacity(0.1),
        radius: radiusValue,
        strokeColor: AppColors.primaryColor,
        strokeWidth: 1,
      ),
    );
    radiusSlider = true;
  }

  //Custom Marker
  void setNearMarker(
      LatLng point, String label, List types, String status) async {
    var counter = markerIdCounter++;

    final Uint8List markerIcon;

    if (types.contains('restaurants')) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    } else if (types.contains('food')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/food.png', 75);
    } else if (types.contains('school')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/schools.png', 75);
    } else if (types.contains('bar')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/bars.png', 75);
    } else if (types.contains('lodging')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/hotels.png', 75);
    } else if (types.contains('store')) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/retail-stores.png', 75);
    } else if (types.contains('locality')) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else {
      markerIcon = await getBytesFromAsset('assets/mapicons/places.png', 75);
    }

    final Marker marker = Marker(
      markerId: MarkerId('marker_$counter'),
      infoWindow: InfoWindow(title: label),
      position: point,
      onTap: () {},
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    _drawPolyline(startMarker.position, marker.position);

    markers.add(marker);
    update();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    update();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _drawPolyline(LatLng from, LatLng to) async {
    polyline = await drawPolyline(from, to);
    if (minDistance == 0) {
      minDistance = totalDistance;
      polylines.add(polyline);
    } else {
      if (totalDistance < minDistance) {
        minDistance = totalDistance;
        polylines.clear();
        polylines.add(polyline);
      }
    }
    update();
  }

  Future<Polyline> drawPolyline(LatLng from, LatLng to) async {
    List<LatLng> polylineCoordinates = [];

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(from.latitude, from.longitude),
        PointLatLng(to.latitude, to.longitude));

    for (var point in result.points) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }
    _calculateDistance(polylineCoordinates);
    update();
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
}
