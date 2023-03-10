import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/data/services/emergency.dart';
import 'package:school_violence_app/app/modules/home_page/widgets/emergency_dialog.dart';

void helpDialog(String userId) async {
  final CollectionReference emergencyCollection =
      FirebaseFirestore.instance.collection('emergency');
  DocumentSnapshot snap = await emergencyCollection.doc(userId).get();
  final Emergency _emergency = Emergency();
  List _friendId = [];
  if (snap.data() != null) {
    _friendId = (snap.data()! as dynamic)['friendId'];
  } else
    _friendId = [];
  if (_friendId.length > 0) {
    //EmergencyDialog();
    Get.dialog(EmergencyDialog());
    _emergency.resetData(userId);
  }
}
