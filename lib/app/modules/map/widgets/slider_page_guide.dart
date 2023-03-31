import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_text_style.dart';

class SliderPageGuide extends StatelessWidget {
  const SliderPageGuide(
      {Key? key, required title, required description, required image})
      : _title = title,
        _description = description,
        _image = image,
        super(key: key);

  final String _title;
  final String _description;
  final String _image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 30.0),
          child: Image.asset(_image, width: 168, height: 159, fit: BoxFit.fill),
        ),
        Text(
          _title,
          style: CustomTextStyle.h2(AppColors.primaryColor),
        ),
        SizedBox(
          height: 50,
          child: Center(
            child: Text(
              _description,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
