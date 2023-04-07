import 'dart:developer';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/values/app_colors.dart';

const String googleApiKey = 'AIzaSyDp9al2OngJ2669NU0cJOyRNm4eQP6sguA';

class PolylineService {
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
    _calcDistance(polylineCoordinates);
    return Polyline(
      polylineId: PolylineId("polyline_id ${result.points.length}"),
      color: AppColors.primaryColor,
      points: polylineCoordinates,
      width: 3,
    );
  }

  void _calcDistance(List<LatLng> polylineCoordinates) {
    double totalDistance = 0.0;

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

    log("distance = ${totalDistance.toStringAsFixed(2)} km");
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
