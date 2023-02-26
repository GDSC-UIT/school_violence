import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';
import 'package:school_violence_app/app/modules/notifications/widgets/acceptButton.dart';

class NameCard extends StatelessWidget {
  NameCard({
    Key? key,
    required index,
  })  : _index = index,
        super(key: key);

  final _index;
  Connect _connect = Connect();
  final ConnectController connectCtrl = Get.find<ConnectController>();
  final NotificationsController notificationsController =
      NotificationsController();

  Future<void> getData() async {
    DocumentSnapshot snapConnect = await FirebaseFirestore.instance
        .collection('connect')
        .doc(connectCtrl.userId.value)
        .get();
    if (snapConnect.data() != null) {
      List friendRequest = (snapConnect.data()! as dynamic)['friendRequest'];
      notificationsController.updateFriendId(friendRequest[_index]);
      DocumentSnapshot snapUsers = await FirebaseFirestore.instance
          .collection('users')
          .doc(notificationsController.friendId.value)
          .get();
      if (snapUsers.data() != null) {
        notificationsController
            .updateName((snapUsers.data()! as dynamic)['fullName']);
        notificationsController
            .updateSchool((snapUsers.data()! as dynamic)['school']);
      }
      List friends = (snapConnect.data()! as dynamic)['friends'];
      String friendId = notificationsController.friendId.value;
      notificationsController.updateIsFriend(friends.contains(friendId));
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Obx(
      () => Card(
        child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text(
              notificationsController.name.value,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                color: AppColors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              notificationsController.school.value,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Montserrat',
                color: AppColors.blur,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: AcceptButton(
              userId: connectCtrl.userId.value,
              friendId: notificationsController.friendId.value,
            ) // AcceptButton() để call thằng còn lại
            ),
      ),
    );
  }
}
