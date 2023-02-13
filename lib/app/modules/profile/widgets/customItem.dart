import 'package:flutter/material.dart';
import 'package:school_violence_app/app/modules/profile/widgets/customCard.dart';

class CustomReportItem extends StatelessWidget {
  const CustomReportItem({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.text,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: .5),
          borderRadius: BorderRadius.all(
              Radius.circular(12.0) //                 <--- border radius here
              ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: thumbnail,
            ),
            Expanded(
              flex: 3,
              child: CustomReportCard(
                title: title,
                subtitle: subtitle,
                text: text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
