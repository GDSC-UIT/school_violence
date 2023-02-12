import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/modules/diary/widgets/Message_User.dart';
import 'package:school_violence_app/app/modules/diary/widgets/Message_Expert.dart';

class DiaryController extends GetxController {
  RxList messages = [
      Message_Expert(mess: "How are you"),
      Message_User(mess: "Find thank you")
    ].obs;

  void updateMessages(Widget mess)=> messages.add(mess);
}
