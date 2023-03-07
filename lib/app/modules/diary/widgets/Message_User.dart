import 'package:flutter/cupertino.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class Message_User extends StatelessWidget {
  final String mess;
  const Message_User({super.key,required this.mess});

  @override
  Widget build(BuildContext context) {
     return Align(
        alignment: Alignment.bottomRight,
       child: Container(
        margin: const EdgeInsets.only(right:26,left:100,top:19),
        padding: const EdgeInsets.only(top: 18, bottom: 18, left: 17, right: 43),
        decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19),
                topRight: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(7))),
        child: Text(
          mess,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600),
        ),
         ),
     );
  }
}