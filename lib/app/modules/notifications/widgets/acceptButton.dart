import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';
import 'package:school_violence_app/app/modules/connect/widgets/add_friend_button.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';

class AcceptButton extends StatelessWidget {
  AcceptButton({
    Key? key,
    required userId,
    required friendId,
  })  : _userId = userId,
        _friendId = friendId,
        super(key: key);
  String _userId;
  String _friendId;
  Connect _connect = Connect();
  final NotificationsController notificationsController =
      Get.find<NotificationsController>();

  final ConnectController ctrl = Get.find<ConnectController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 25,
        width: !notificationsController.isFriend.value ? 72 : 108,
        child: Obx(
          () => ElevatedButton(
            style: !notificationsController.isFriend.value
                ? ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: AppColors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : ElevatedButton.styleFrom(
                    foregroundColor: AppColors
                        .primaryColor, //change background color of button
                    backgroundColor:
                        AppColors.white, //change text color of button
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 1, color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: AppColors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            child: !notificationsController.isFriend.value
                ? (Text(
                    'Accept',
                  ))
                : (Text(
                    'Accepted ✓',
                  )),
            onPressed: () async {
              if (!notificationsController.isFriend.value) {
                await _connect.friends(
                  _userId,
                  _friendId,
                );
                await _connect.unFriendRequest(
                  _friendId,
                  _userId,
                );
                await _connect.friends(_friendId, _userId);
                await _connect.unSentRequest(
                  _friendId,
                  _userId,
                );
                notificationsController.updateIsFriend(true);
              } else {}
            },
          ),
        ),
      ),
    );
  }
}
