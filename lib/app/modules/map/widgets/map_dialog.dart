import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/modules/intro/widgets/indicator.dart';
import 'package:school_violence_app/app/modules/map/map_controller.dart';
import 'package:school_violence_app/app/modules/profile/widgets/customItem.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';

class MapDialog extends StatefulWidget {
  const MapDialog({super.key});

  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> with TickerProviderStateMixin {
  late TextEditingController _controller;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 474),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DefaultTabController(
            length: 2,
            child: SizedBox(
              height: 450,
              width: 330,
              child: PageView(
                children: [
                  Column(
                    children: [
                      // need to replace this Text -> Pictures
                      Image.asset('assets/images/signup_img.png',
                          width: 292, height: 270, fit: BoxFit.fill),
                      const SizedBox(height: 20),
                      Text(
                        'Ở đây là hướng dẫn 1',
                        style: CustomTextStyle.h2(AppColors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shadowColor: AppColors.primaryColorShadow,
                          elevation: 5,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: Text(
                          "OK",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.button(AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // need to replace this Text -> Pictures
                      Image.asset('assets/images/signup_img.png',
                          width: 292, height: 270, fit: BoxFit.fill),
                      const SizedBox(height: 20),
                      Text(
                        'Ở đây là hướng dẫn 2',
                        style: CustomTextStyle.h2(AppColors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shadowColor: AppColors.primaryColorShadow,
                          elevation: 5,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: Text(
                          "OK",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.button(AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // need to replace this Text -> Pictures
                      Image.asset('assets/images/signup_img.png',
                          width: 292, height: 270, fit: BoxFit.fill),
                      const SizedBox(height: 20),
                      Text(
                        'Ở đây là hướng dẫn 3',
                        style: CustomTextStyle.h2(AppColors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shadowColor: AppColors.primaryColorShadow,
                          elevation: 5,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: Text(
                          "OK",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.button(AppColors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
