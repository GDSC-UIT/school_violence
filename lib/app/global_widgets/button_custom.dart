import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    Key? key,
    required heightButton,
    required widthButton,
    required textValue,
    required buttonColor,
    required textStyle,
    buttonShadowColor,
    onPress,
  })  : _heightButton = heightButton,
        _widthButton = widthButton,
        _textValue = textValue,
        _buttonColor = buttonColor,
        _textStyle = textStyle,
        _buttonShadowColor = buttonShadowColor,
        _callBack = onPress,
        super(key: key);

  final double _heightButton;
  final double _widthButton;
  final String _textValue;
  final Color _buttonColor;
  final Color _buttonShadowColor;
  final TextStyle _textStyle;
  final VoidCallback? _callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _callBack,
      child: Container(
        height: _heightButton,
        width: _widthButton,
        decoration: BoxDecoration(
          color: _buttonColor,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: _buttonShadowColor,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            _textValue,
            style: _textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
