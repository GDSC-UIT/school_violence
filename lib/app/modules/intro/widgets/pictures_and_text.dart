import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';
import 'package:school_violence_app/app/modules/intro/intro_controller.dart';

class picturesAndText extends StatelessWidget {
  const picturesAndText({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  final IntroController ctrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      child: PageView.builder(
        onPageChanged: (index) {
          ctrl.updateSelectedIndex(index);
        },
        controller: PageController(viewportFraction: 1),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            children: [
              // need to replace this Text -> Pictures
              Image.asset('assets/images/signup_img.png',
                  width: 300, height: 280, fit: BoxFit.fill),
              SizedBox(height: 10),
              Text(
                'Connect & share with\nexpert whenever and\nwherever you want',
                style: CustomTextStyle.h1(AppColors.black),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
