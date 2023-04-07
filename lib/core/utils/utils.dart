import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng getPolygonCenter(List<LatLng> polygonPoints) {
  double lat = 0;
  double lng = 0;

  for (LatLng point in polygonPoints) {
    lat += point.latitude;
    lng += point.longitude;
  }

  int numPoints = polygonPoints.length;
  lat /= numPoints;
  lng /= numPoints;

  return LatLng(lat, lng);
}
