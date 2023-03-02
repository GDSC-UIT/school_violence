import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';

class FullNameField extends StatelessWidget {
  const FullNameField({
    Key? key,
    required fullNameController,
  })  : _fullNameController = fullNameController,
        super(key: key);

  final TextEditingController _fullNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _fullNameController,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
        ),
      ),
      validator: (val) => val!.isEmpty ? 'Enter an Full Name' : null,
      onChanged: (val) {
        //setState(() => userName = val);
      },
    );
  }
}
