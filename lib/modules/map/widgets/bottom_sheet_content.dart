import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/values/app_colors.dart';
import '../../../data/services/push_notification_service.dart';
import '../map_controller.dart';
import '../services/map_service.dart';

enum TypeBully { violence, shooting }

enum Building { A, B, C }

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final TextEditingController _messageController = TextEditingController();
  final mapController = Get.find<MapController>();

  TypeBully _typeValue = TypeBully.violence;
  Building selectedBuilding = Building.A;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: Get.width,
        height: Get.height * 0.7,
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
              height: 10,
            ),
            const Text(
              "Message",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
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
            const Text(
              "Type",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Radio(
                  value: TypeBully.violence,
                  groupValue: _typeValue,
                  onChanged: (typeBully) {
                    setState(() {
                      _typeValue = typeBully as TypeBully;
                    });
                  },
                  activeColor: AppColors.primaryColor,
                ),
                const SizedBox(
                  width: 2.0,
                ),
                const Text("Violence"),
                const Spacer(),
                Radio(
                  value: TypeBully.shooting,
                  groupValue: _typeValue,
                  onChanged: (typeBully) {
                    setState(() {
                      _typeValue = typeBully as TypeBully;
                    });
                  },
                  activeColor: AppColors.primaryColor,
                ),
                const SizedBox(
                  width: 2.0,
                ),
                const Text("School Shooting"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: (_typeValue == TypeBully.shooting) ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Where (building)",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: Building.A,
                              groupValue: selectedBuilding,
                              onChanged: (value) {
                                setState(() {
                                  selectedBuilding = value!;
                                });
                              },
                              activeColor: AppColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 2.0,
                            ),
                            const Text("A"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: Building.B,
                              groupValue: selectedBuilding,
                              onChanged: (value) {
                                setState(() {
                                  selectedBuilding = value!;
                                });
                              },
                              activeColor: AppColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 2.0,
                            ),
                            const Text("B"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              value: Building.C,
                              groupValue: selectedBuilding,
                              onChanged: (value) {
                                setState(() {
                                  selectedBuilding = value!;
                                });
                              },
                              activeColor: AppColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 2.0,
                            ),
                            const Text("C"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
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
                mapController.alertButton.value = false;
                mapController.guideButton.value = false;
                mapController.bottomSheetStatus.value = true;
                if (_typeValue == TypeBully.shooting) {
                  sendPushMessage(
                      building: selectedBuilding.toString().substring(6));
                  mapController.drawShootingBuilding(
                      '${selectedBuilding.toString().substring(6)}_Tower');
                } else {
                  findClosestSafePlace();
                }
                Navigator.pop(context);
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
  }

  Future<void> findClosestSafePlace() async {
    setState(() {
      mapController.closeButton.value = true;
      mapController.setCircle(mapController.currentPositon);
    });
    if (mapController.debounce?.isActive ?? false) {
      mapController.debounce?.cancel();
    }
    mapController.debounce = Timer(
      const Duration(seconds: 1),
      () async {
        var placesResult = await MapServices().getPlaceDetails(
            mapController.currentPositon, mapController.radiusValue.toInt());

        List<dynamic> placesWithin = placesResult['results'] as List;

        mapController.allFavoritePlaces.value = placesWithin;

        mapController.tokenKey = placesResult['next_page_token'] ?? 'none';

        for (var element in placesWithin) {
          if (element['opening_hours'] != null) {
            mapController.setNearMarker(
              LatLng(
                element['geometry']['location']['lat'],
                element['geometry']['location']['lng'],
              ),
              element['name'],
              element['types'],
              element['business_status'] ?? 'not available',
            );
          }
        }
        // _markersDupe = _markers;
      },
    );
  }
}
