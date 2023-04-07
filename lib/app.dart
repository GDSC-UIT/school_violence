import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/routes/app_pages.dart';
import 'package:school_violence_app/routes/app_routes.dart';

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
              : (isViewed != 0 ? AppRoutes.intro : AppRoutes.signIn),
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
