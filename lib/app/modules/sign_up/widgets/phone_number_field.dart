import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (value) {},
      textStyle: TextStyle(
        fontSize: 20,
        fontFamily: 'Montserrat',
      ),
      cursorColor: AppColors.primaryColor,
      formatInput: false,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      inputDecoration: const InputDecoration(
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.transparent, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
      ),
    );
  }
}