import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'main.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: isEmergency
          ? AppRoutes.map
          : isLogged
              ? AppRoutes.home
              : (isViewed != 0 ? AppRoutes.intro : AppRoutes.sign_in),
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
