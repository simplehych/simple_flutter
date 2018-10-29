import 'package:flutter/material.dart';
import 'package:simple_flutter/style/string/string_base.dart';
import 'package:simple_flutter/style/string/string_en.dart';

class GlobalLocalizations {
  final Locale locale;

  GlobalLocalizations(this.locale);

  static Map<String, StringBase> _localizedValues = {
    'en': new StringEn(),
    'zh': new StringEn(),
  };

  StringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  static GlobalLocalizations of(BuildContext context) {
    return Localizations.of(context, GlobalLocalizations);
  }
}
