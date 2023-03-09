import 'package:flutter/material.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/core/values/app_text_style.dart';

// customize FormHelper package
class FormHelper {
  static Widget dropDownWidget(
    BuildContext context,
    String hintText,
    dynamic value,
    List<dynamic> listData,
    Function onChanged,
    Function onValidate, {
    double hintFontSize = 15,
    Color borderColor = Colors.redAccent,
    double borderRadius = 30,
    Color borderFocusColor = Colors.redAccent,
    double paddingLeft = 20,
    double paddingRight = 20,
    double paddingTop = 0,
    double paddingBottom = 0,
    String optionValue = "ID",
    String optionLabel = "Name",
    double contentPadding = 6,
    Color validationColor = Colors.redAccent,
    Color textColor = Colors.black,
    Color hintColor = Colors.black,
    double borderWidth = 2,
    double focusedBorderWidth = 2,
    double enabledBorderWidth = 1,
    Widget? suffixIcon,
    Icon? prefixIcon,
    bool showPrefixIcon = false,
    Color prefixIconColor = Colors.redAccent,
    double prefixIconPaddingLeft = 30,
    double prefixIconPaddingRight = 10,
    double prefixIconPaddingTop = 0,
    double prefixIconPaddingBottom = 0,
  }) {
    if (value != "") {
      var findValue = listData
          .where((item) => item[optionValue].toString() == value.toString());

      if (findValue.length > 0) {
        value = findValue.first[optionValue].toString();
      } else {
        value = null;
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        left: paddingLeft,
        right: paddingRight,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: FormField<dynamic>(
        builder: (FormFieldState<dynamic> state) {
          return DropdownButtonFormField<String>(
            isExpanded: true,
            value: value != "" ? value : null,
            isDense: true,
            hint: Text(
              hintText,
              style: TextStyle(
                fontSize: hintFontSize,
              ),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(contentPadding),
              errorStyle: TextStyle(
                color: validationColor,
              ),
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: hintFontSize,
                color: hintColor,
              ),
              hintText: hintText,
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: AppColors.black,
                  //width: enabledBorderWidth,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderFocusColor,
                  width: focusedBorderWidth,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: showPrefixIcon
                  ? Padding(
                      child: IconTheme(
                        data: IconThemeData(color: prefixIconColor),
                        child: prefixIcon!,
                      ),
                      padding: EdgeInsets.only(
                        left: prefixIconPaddingLeft,
                        right: prefixIconPaddingRight,
                        top: prefixIconPaddingTop,
                        bottom: prefixIconPaddingBottom,
                      ),
                    )
                  : null,
            ),
            // decoration: InputDecoration(
            //   contentPadding: EdgeInsets.all(contentPadding),
            //   hintStyle: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: hintFontSize,
            //   ),
            //   enabledBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(borderRadius),
            //     borderSide: BorderSide(
            //       color: borderColor,
            //       width: 1,
            //     ),
            //   ),
            //   border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(borderRadius),
            //     borderSide: BorderSide(
            //       color: borderColor,
            //       width: 2,
            //     ),
            //   ),
            //   focusedBorder: OutlineInputBorder(
            //     borderSide: BorderSide(
            //       color: borderFocusColor,
            //       width: 2.0,
            //     ),
            //     borderRadius: BorderRadius.circular(borderRadius),
            //   ),
            // ),
            onChanged: (newValue) {
              //  FocusScope.of(context).requestFocus(new FocusNode());
              state.didChange(newValue);
              return onChanged(newValue);
            },
            validator: (value) {
              return onValidate(value);
            },
            items: listData.map<DropdownMenuItem<String>>(
              (dynamic data) {
                return DropdownMenuItem<String>(
                  value: data[optionValue].toString(),
                  child: new Text(
                    data[optionLabel],
                    style: CustomTextStyle.input(AppColors.black),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}

// data for picker
class Picker {
  List<Map> countries = [
    {
      'ID': 1,
      'Name': 'Vietnam',
    },
    {
      'ID': 2,
      'Name': 'Korea',
    },
    {
      'ID': 3,
      'Name': 'Japan',
    },
  ];

  //

  List<Map> provinces = [
    {
      'ID': 1,
      'Name': 'Binh Dinh',
      'ParentId': 1,
    },
    {
      'ID': 2,
      'Name': 'Tay Ninh',
      'ParentId': 1,
    },
  ];

  //

  List<Map> cities = [
    {
      'ID': '1.1',
      'Name': 'Quy Nhon',
      'ParentId': 1,
    },
    {
      'ID': '1.2',
      'Name': 'Hoai An',
      'ParentId': 1,
    },
    {
      'ID': '2.1',
      'Name': 'Tay Ninh',
      'ParentId': 2,
    },
    {
      'ID': '2.2',
      'Name': 'Hoa Thanh',
      'ParentId': 2,
    },
  ];

  //

  List<Map> schools = [
    {
      'ID': '1.1',
      'Name': 'Quy Nhon College',
      'ParentId': '1.1',
    },
    {
      'ID': '1.2',
      'Name': 'Trung Vuong High School',
      'ParentId': '1.1',
    },
    {
      'ID': '1.3',
      'Name': 'Le Quy Don High School for the gifted',
      'ParentId': '1.1',
    },
    {
      'ID': '2.1',
      'Name': 'Hoang Le Kha High School for the gifted',
      'ParentId': '2.1',
    },
    {
      'ID': '2.2',
      'Name': 'Tay Ninh High School',
      'ParentId': '2.1',
    },
    {
      'ID': '3.1',
      'Name': 'Ly Thuong Kiet High School',
      'ParentId': '2.2',
    },
  ];
}
