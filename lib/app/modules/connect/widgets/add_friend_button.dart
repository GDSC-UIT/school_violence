import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';

class AddFriendButton extends StatelessWidget {
  AddFriendButton({
    Key? key,
    required this.ctrl,
    required Connect connect,
    required index,
  })  : _connect = connect,
        _index = index,
        super(key: key);

  final ConnectController ctrl;
  final Connect _connect;
  final _index;
  final NotificationsController notificationsCtrl =
      Get.find<NotificationsController>();

  Future<void> getData() async {
    DocumentSnapshot snapConnect = await FirebaseFirestore.instance
        .collection('connect')
        .doc(ctrl.userId.value)
        .get();
    if (snapConnect.data() != null) {
      List friends = (snapConnect.data()! as dynamic)['friends'];
      String friendId = ctrl.searchResult[ctrl.id.value]['id'];
      notificationsCtrl.updateIsFriend(friends.contains(friendId));
    }
  }

  @override
  Widget build(BuildContext context) {
    ctrl.updateId(_index);
    getData();
    return Obx(
      () => ElevatedButton(
        onPressed: () {
          if (ctrl.isSent.value && !notificationsCtrl.isFriend.value) {
            _connect.sentRequest(
              ctrl.userId.value,
              ctrl.searchResult[ctrl.id.value]['id'],
            );
            _connect.friendRequest(
              ctrl.userId.value,
              ctrl.searchResult[ctrl.id.value]['id'],
            );
          } else if (!ctrl.isSent.value && !notificationsCtrl.isFriend.value) {
            _connect.unSentRequest(
              ctrl.userId.value,
              ctrl.searchResult[ctrl.id.value]['id'],
            );
            _connect.unFriendRequest(
              ctrl.userId.value,
              ctrl.searchResult[ctrl.id.value]['id'],
            );
          } else {}
          ctrl.updateIsSent(!ctrl.isSent.value);
        },
        style: ((ctrl.isSent.value && !notificationsCtrl.isFriend.value) ||
                notificationsCtrl.isFriend.value)
            ? ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
        child: (ctrl.isSent.value && !notificationsCtrl.isFriend.value)
            ? Text('Add')
            : (!ctrl.isSent.value && !notificationsCtrl.isFriend.value)
                ? Text(
                    'Sent ✓',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  )
                : Icon(Icons.child_friendly),
      ),
    );
  }
}
