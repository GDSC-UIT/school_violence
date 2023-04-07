import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';
import '../intro_controller.dart';

class PicturesAndText extends StatelessWidget {
  const PicturesAndText({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  final IntroController ctrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: 330,
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
                  width: 292, height: 270, fit: BoxFit.fill),
              const SizedBox(height: 40),
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
