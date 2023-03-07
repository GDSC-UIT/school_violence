import 'package:flutter/cupertino.dart';

class CustomTextStyle extends TextStyle {
  static TextStyle h1(Color color) {
    return TextStyle(
      fontSize: 24,
      fontFamily: 'Ubuntu',
      color: color,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle h2(Color color) {
    return TextStyle(
      fontSize: 20,
      fontFamily: 'Ubuntu',
      color: color,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle label(Color color) {
    return TextStyle(
      fontSize: 18,
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
      fontSize: 16,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w600,
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
