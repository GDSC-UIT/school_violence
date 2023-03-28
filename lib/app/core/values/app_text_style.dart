import 'package:flutter/cupertino.dart';

class CustomTextStyle extends TextStyle {
  static TextStyle h1(Color color) {
    return TextStyle(
      fontSize: 26,
      fontFamily: 'Ubuntu',
      color: color,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  static TextStyle h2(Color color) {
    return TextStyle(
      fontSize: 20,
      fontFamily: 'Ubuntu',
      color: color,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle label(Color color) {
    return TextStyle(
      fontSize: 14,
      fontFamily: 'Ubuntu',
      color: color,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle input(Color color) {
    return TextStyle(
      fontSize: 20,
      fontFamily: 'Ubuntu',
      color: color,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle desc(Color color) {
    return TextStyle(
      fontSize: 16,
      fontFamily: 'Ubuntu',
      color: color,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle button(Color color) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle small_desc(Color color) {
    return TextStyle(
      color: color,
      fontSize: 12,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w600,
    );
  }
}
