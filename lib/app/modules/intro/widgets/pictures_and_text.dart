import 'package:flutter/material.dart';
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
            children: const [
              // need to replace this Text -> Pictures
              Text(
                'A',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 175),
              ),
              SizedBox(
                height: 80,
              ),
              Text(
                'Connect & share with\nexpert whenever and\nwherever you want',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}