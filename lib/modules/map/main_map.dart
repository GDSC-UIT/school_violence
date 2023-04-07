import 'package:flutter/material.dart';
import 'package:school_violence_app/modules/map/screens/map_home_screen.dart';

class MyMap extends StatelessWidget {
  const MyMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Google Maps',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MapHomeScreen(),
    );
  }
}
