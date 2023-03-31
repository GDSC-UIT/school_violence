import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/map/widgets/start_button.dart';
import '../../../core/values/app_colors.dart';

enum TypeBullyEnum { violence, shooting }

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final TextEditingController _messageController = TextEditingController();

  TypeBullyEnum? _typeBullyEnum;

  @override
  Widget build(BuildContext context) {
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
                        _messageController.text = newValue;
                      });
                    },
                    initialValue: _messageController.text,
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
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor),
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
                            _typeBullyEnum = newTypeBully;
                          });
                        },
                        activeColor: AppColors.primaryColor,
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
                            _typeBullyEnum = newTypeBully;
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
            // ElevatedButton(
            //   onPressed: () async {
            //     Navigator.pop(context);
            //     alertButton = false;
            //     guideButton = false;
            //     bottomSheetStatus = true;
            //     if (_typeBullyEnum == TypeBullyEnum.violence) {
            //       setState(() {
            //         closeButton = true;
            //         _setCircle(_currentPositon);
            //       });
            //       if (_debounce?.isActive ?? false) _debounce?.cancel();
            //       _debounce = Timer(
            //         Duration(seconds: 1),
            //         () async {
            //           var placesResult = await MapServices().getPlaceDetails(
            //               _currentPositon, radiusValue.toInt());

            //           List<dynamic> placesWithin =
            //               placesResult['results'] as List;

            //           allFavoritePlaces = placesWithin;

            //           tokenKey = placesResult['next_page_token'] ?? 'none';

            //           placesWithin.forEach((element) {
            //             if (element['opening_hours'] != null) {
            //               _setNearMarker(
            //                 LatLng(
            //                   element['geometry']['location']['lat'],
            //                   element['geometry']['location']['lng'],
            //                 ),
            //                 element['name'],
            //                 element['types'],
            //                 element['business_status'] ?? 'not available',
            //               );
            //             }
            //           });
            //           // _markersDupe = _markers;
            //         },
            //       );
            //     } else if (_typeBullyEnum == TypeBullyEnum.shooting) {
            //       print('shooting');
            //     }
            //   },
            //   style: ElevatedButton.styleFrom(
            //     shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(30),
            //       ),
            //     ),
            //     backgroundColor: AppColors.primaryColor,
            //     elevation: 0,
            //     minimumSize: const Size(380, 50),
            //   ),
            //   child: const Text(
            //     "Start",
            //     style: TextStyle(fontSize: 16),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
