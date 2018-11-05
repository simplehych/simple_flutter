import 'package:flutter/material.dart';

class GlobalTextStyle {
  static const _maxSize = 30.0;
  static const _largeSize = 20.0;
  static const _bigSize = 18.0;
  static const _normalSize = 16.0;
  static const _smallSize = 14.0;
  static const _minSize = 12.0;

  static const _normalColor = Color(0xFFFFFFFF);
  static const _subColor = Color(0x999999);

  static const normal = TextStyle(
    color: _normalColor,
    fontSize: _normalSize,
  );
}
