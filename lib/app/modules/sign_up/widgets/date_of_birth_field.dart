import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/modules/sign_up/sign_up_controller.dart';

class DateOfBirthField extends StatelessWidget {
  DateOfBirthField({
    Key? key,
    required dateController,
  })  : _dateController = dateController,
        super(key: key);

  final TextEditingController _dateController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
        suffixIcon: Icon(Icons.book_online_rounded),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          _dateController.text = Text(
            formatDate(
              pickedDate,
              [mm, '/', dd, '/', yyyy],
            ),
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
            ),
          ).data!;
        }
      },
      validator: (val) => val!.isEmpty ? 'Enter an Date of Birth' : null,
    );
  }
}
