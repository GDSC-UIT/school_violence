import 'package:flutter/cupertino.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class Message_Orther extends StatelessWidget {
  final String mess;
  const Message_Orther({super.key,required this.mess});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 26, right: 100, top: 19),
        padding: const EdgeInsets.only(top: 18, bottom: 18, left: 17, right: 43),
        decoration: const BoxDecoration(
            color: Color(0xFFEFEFEF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19))),
        child: Text(
          mess,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
