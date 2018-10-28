import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

final LocaleReducer = combineReducers<Locale>([
  TypedReducer<Locale, RefreshLocalAction>(_refresh),
]);

Locale _refresh(Locale locale, RefreshLocalAction action) {
  locale = action.locale;
  return locale;
}

class RefreshLocalAction {
  final Locale locale;

  RefreshLocalAction(this.locale);
}
