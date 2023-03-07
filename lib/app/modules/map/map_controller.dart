import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapController extends GetxController {
  RxDouble latitude = 0.0.obs;
  RxDouble longtitude = 0.0.obs;

  void updateLatitude(double data) => latitude.value = data;

  void updateLongtitude(double data) => longtitude.value = data;
}
