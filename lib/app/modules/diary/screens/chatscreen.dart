import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/diary/widgets/Message_User.dart';
import 'package:school_violence_app/app/modules/diary/widgets/Message_Orther.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';
import 'package:flutter/scheduler.dart';
import '../diary_controller.dart';

class ChatScreen extends StatelessWidget {
  final String initial_text;
  final List roomUser;
  final String nowUser;
  ChatScreen(
      {super.key,
      required this.initial_text,
      required this.roomUser,
      required this.nowUser});

  final DiaryController ctrl = Get.find<DiaryController>();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> chatkey = GlobalKey<FormState>();
    TextEditingController mess = TextEditingController();
    final ScrollController controller = ScrollController();

    void _scrollDown() {
      controller.animateTo(
        controller.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 200),
      );
    }

    //khoi tao text ban dau khi tao phong chat
    if (initial_text != "") {
      FirebaseFirestore.instance.collection("messages").add({
        "data": initial_text,
        "userOwn": nowUser,
        "roomUser": roomUser,
        "createdAt": DateTime.now().microsecondsSinceEpoch
      });
    }
    //this function will trigger 1 time when this page have done rendered, use to scroll down to bottom of listview of messages
    //AND fetch mess
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (ctrl.messages.isNotEmpty) {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
      var fetchRef = FirebaseFirestore.instance.collection("messages");
      fetchRef
          .where("roomUser", isEqualTo: roomUser)
          .orderBy("createdAt")
          .snapshots()
          .listen(
        (event) {
          List data = event.docs.map((element) {
            if (element.data()["userOwn"] == nowUser) {
              return Message_User(mess: element["data"]);
            }
            if (element.data()["userOwn"] != nowUser) {
              return Message_Orther(mess: element["data"]);
            }
          }).toList();
          if (data.isNotEmpty) {
            ctrl.updateMessages(data);
            mess.clear();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollDown();
            });
          }
        },
        onError: (error) => print("Listen failed: $error"),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Expert",
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              iconSize: 28,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                ctrl.updateMessages([]);
                Get.toNamed(AppRoutes.diary);
              },
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
                size: 24,
              ))
        ],
        backgroundColor: Colors.white,
        toolbarHeight: 90,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //mess space
          Expanded(child: Obx(() {
            if (ctrl.messages.isEmpty) {
              return const SizedBox();
            } else {
              return ListView(
                controller: controller,
                children: ctrl.messages
                    .map((element) => Container(
                          child: element,
                        ))
                    .toList(),
              );
            }
          })),
          const SizedBox(
            height: 20,
          ),
          //input space
          Container(
            margin: const EdgeInsets.only(bottom: 52),
            child: Form(
              key: chatkey,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 26, right: 15),
                      child: TextFormField(
                        controller: mess,
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFEFEFEF),
                          filled: true,
                          hintText: "Type a message to Expert ...",
                          hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return "";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(right: 22),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(28)),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (chatkey.currentState!.validate()) {
                              await FirebaseFirestore.instance
                                  .collection("messages")
                                  .add({
                                "data": mess.text,
                                "userOwn": nowUser,
                                "roomUser": roomUser,
                                "createdAt":
                                    DateTime.now().microsecondsSinceEpoch
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shadowColor: AppColors.primaryColorShadow,
                            elevation: 5,
                            minimumSize: const Size(300, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          child: const Icon(Icons.send_rounded)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
