import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../data/services/connect.dart';
import '../../connect/connect_controller.dart';
import '../notifications_controller.dart';

class AcceptButton extends StatelessWidget {
  AcceptButton({
    Key? key,
    required userId,
    required friendId,
  })  : _userId = userId,
        _friendId = friendId,
        super(key: key);
  final String _userId;
  final String _friendId;
  final Connect _connect = Connect();
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
                    backgroundColor: AppColors.primaryColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    textStyle: const TextStyle(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: AppColors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            child: !notificationsController.isFriend.value
                ? (const Text(
                    'Accept',
                  ))
                : (const Text(
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
