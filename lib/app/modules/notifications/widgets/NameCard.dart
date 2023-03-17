import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';
import 'package:school_violence_app/app/modules/notifications/notifications_controller.dart';
import 'package:school_violence_app/app/modules/notifications/widgets/acceptButton.dart';
import 'package:school_violence_app/app/modules/sign_in/sign_in_controller.dart';

class NameCard extends StatelessWidget {
  NameCard({
    Key? key,
    required index,
  })  : _index = index,
        super(key: key);

  final _index;
  Connect _connect = Connect();
  final ConnectController connectCtrl = Get.find<ConnectController>();
  final SignInController signInCtrl = Get.find<SignInController>();
  final NotificationsController notificationsController =
      NotificationsController();

  void getData() async {
    DocumentSnapshot snapConnect = await FirebaseFirestore.instance
        .collection('connect')
        .doc(signInCtrl.userId.value)
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
            style: CustomTextStyle.h2(AppColors.black),
          ),
          subtitle: Text(
            notificationsController.school.value,
            style: CustomTextStyle.small_desc(AppColors.blur),
          ),
          trailing: AcceptButton(
            userId: signInCtrl.userId.value,
            friendId: notificationsController.friendId.value,
          ), // AcceptButton() để call thằng còn lại
        ),
      ),
    );
  }
}
