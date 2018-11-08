import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/redux/global_state.dart';

class GlobalColors {
  static const int white = 0xffffffff;

  static Color theme(BuildContext context) {
    return StoreProvider.of<GlobalState>(context).state.themeData.primaryColor;
  }
}
