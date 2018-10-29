import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter/manager/localization/global_localizations.dart';
import 'package:simple_flutter/style/string/string_base.dart';

class GlobalLocalizationsDelegate extends LocalizationsDelegate<GlobalLocalizations> {

  static GlobalLocalizationsDelegate delegate = GlobalLocalizationsDelegate();

  GlobalLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<GlobalLocalizations> load(Locale locale) {
    return new SynchronousFuture<GlobalLocalizations>(new GlobalLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<GlobalLocalizations> old) {
    return false;
  }


}