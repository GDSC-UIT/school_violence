import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/values/app_colors.dart';

enum TypeBully { Violence, Shooting }

class BottomSheetContent extends StatelessWidget {
  BottomSheetContent({super.key});

  final TextEditingController _messageController = TextEditingController();
  final TypeBully _typeValue = TypeBully.Violence;

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: simSlot,
    ).then((SmsStatus status) {
      if (status == "sent") {
        print("sent");
      } else {
        print("failed");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: Get.width,
        height: Get.height * 0.5,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Message",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
                hintStyle: const TextStyle(
                  color: AppColors.primaryColor,
                ),
                label: const Text(
                  "Type a message to report (optional)",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Type",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Row(
                children: [
                  Radio(
                    value: TypeBully.Violence,
                    groupValue: _typeValue,
                    onChanged: (typeBully) {},
                    activeColor: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 2.0,
                  ),
                  const Text("Violence"),
                  const SizedBox(
                    width: 80,
                  ),
                  Radio(
                    value: TypeBully.Shooting,
                    groupValue: _typeValue,
                    onChanged: (typeBully) {},
                    activeColor: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 2.0,
                  ),
                  const Text("School Shooting"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: AppColors.grey,
              height: 1.0,
              width: double.infinity,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                backgroundColor: AppColors.primaryColor,
                elevation: 0,
                minimumSize: const Size(380, 50),
              ),
              child: const Text(
                "Start",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}