import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/diary/widgets/Message_User.dart';
import 'package:school_violence_app/app/modules/diary/widgets/Message_Expert.dart';
import 'package:school_violence_app/app/routes/app_routes.dart';
import 'package:flutter/scheduler.dart';
import '../diary_controller.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  
  
  final DiaryController ctrl = Get.find<DiaryController>();
  
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _chatkey = GlobalKey<FormState>();
    TextEditingController _mess = TextEditingController();
    final ScrollController _controller = ScrollController();

    void _scrollDown() {
      _controller.animateTo(
            _controller.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
    }
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
          Expanded(
            child: Container(
                child: Obx(
                  ()  {
                    return ListView.builder(
                      controller: _controller,
                      itemCount: ctrl.messages.length,
                      itemBuilder: (context, index) => ctrl.messages[index]);}
                )),
              
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(bottom: 52),
            child: Form(
              key: _chatkey,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 26, right: 15),
                      child: TextFormField(
                        controller: _mess,
                        decoration: InputDecoration(
                          fillColor: Color(0xFFEFEFEF),
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
                      margin: EdgeInsets.only(right: 22),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(28)),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_chatkey.currentState!.validate()) {
                              ctrl.updateMessages(Message_User(mess: _mess.text));
                              _mess.clear();
                              SchedulerBinding.instance?.addPostFrameCallback((_) {
                              _scrollDown();
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
                          child: Icon(Icons.send_rounded)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
