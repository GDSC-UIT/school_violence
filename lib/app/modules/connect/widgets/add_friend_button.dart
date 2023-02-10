import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';

class AddFriendButton extends StatelessWidget {
  const AddFriendButton({
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

  @override
  Widget build(BuildContext context) {
    return Obx(() => ElevatedButton(
          onPressed: () {
            if (ctrl.isSent.value) {
              _connect.sentRequest(
                ctrl.userId.value,
                ctrl.searchResult[_index]['id'],
              );
            } else {
              _connect.unSentRequest(
                  ctrl.userId.value, ctrl.searchResult[_index]['id']);
            }
            ctrl.updateIsSent(!ctrl.isSent.value);
          },
          style: (ctrl.isSent.value)
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
          child: (ctrl.isSent.value)
              ? Text('Add')
              : Text(
                  'Sent ✓',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
        ));
  }
}
