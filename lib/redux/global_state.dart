import 'package:flutter/material.dart';
import 'package:simple_flutter/redux/theme_data_reducer.dart';
import 'locale_reducer.dart';

class GlobalState {
  ThemeData themeData;
  Locale locale;
  Locale platformLocale ;

  GlobalState({this.themeData, this.locale});
}

GlobalState appReducer(GlobalState state, dynamic action) {
  return GlobalState(
    themeData: ThemeDataReducer(state.themeData, action),
    locale: LocaleReducer(state.locale, action),
  );
}
