import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

import '../screens/chatscreen.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final SignInController ctrl = Get.find<SignInController>();
  var messages = [];
  @override
  void initState() {
    fetchRoom();
    super.initState();
  }

  fetchRoom() async {
    FirebaseFirestore.instance
        .collection("room")
        .where("roomUser", arrayContains: ctrl.userId.value)
        .snapshots()
        .listen((event) => setState(() {
              messages =
                  event.docs.map((e) => MessRoom.fromJson(e.data())).toList();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? const SizedBox()
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {

              return GestureDetector(
                onTap: () {
                  Get.to(() => ChatScreen(
                        initial_text: "",
                        roomUser: messages[index].roomUser,
                        nowUser: ctrl.userId.value,
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  color: AppColors.primaryColor,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Chat room $index',
                      style: const TextStyle(color: AppColors.white, fontSize: 18),
                    ),
                  ),
                ),
              );
            });
  }
}

class MessRoom {
  final List roomUser;
  MessRoom({
    required this.roomUser,
  });
  static MessRoom fromJson(Map<String, dynamic> json) =>
      MessRoom(roomUser: json["roomUser"]);
}
