import 'package:flutter/material.dart';
import 'package:simple_flutter/style/global_colors.dart';

class GlobalTextStyle {
  static const _maxSize = 30.0;
  static const _largeSize = 20.0;
  static const _bigSize = 18.0;
  static const _normalSize = 16.0;
  static const _smallSize = 14.0;
  static const _minSize = 12.0;

  static const _normalColor = Color(0xFF000000);
  static const _subColor = Color(0xFF999999);


  static TextStyle theme(BuildContext context){
    return TextStyle(
      fontSize: _normalSize,
      color: GlobalColors.theme(context),
    );
  }

  static const big = TextStyle(
    fontSize: _bigSize,
    color: _normalColor,
    fontWeight: FontWeight.bold,
  );

  static const normal = TextStyle(
    fontSize: _normalSize,
    color: _normalColor,
  );

  static const small = TextStyle(
    fontSize: _smallSize,
    color: _subColor,
  );
}
