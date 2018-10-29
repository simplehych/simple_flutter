import 'package:flutter/material.dart';
import 'package:simple_flutter/manager/localization/global_localizations.dart';
import 'package:simple_flutter/style/string/string_base.dart';

class Strings {
  static StringBase of(BuildContext context) {
    return GlobalLocalizations.of(context).currentLocalized;
  }
}
