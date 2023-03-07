import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/diary/widgets/Message_User.dart';
import 'package:school_violence_app/app/modules/diary/widgets/Message_Orther.dart';

class DiaryController extends GetxController {
  RxList messages = [ ].obs;
  RxString userId = ''.obs;
  RxBool haveText = false.obs;
  RxBool isFetchingExpert = false.obs;
  void updateMessages(var mess){
    messages.value=mess;
  }
}
