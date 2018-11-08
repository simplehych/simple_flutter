import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:simple_flutter/manager/theme_data_manager.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/redux/locale_reducer.dart';
import 'package:simple_flutter/redux/theme_data_reducer.dart';
import 'package:simple_flutter/storage/sp/sp_storage.dart';

class StoreManager {
  static refreshLanguage(BuildContext context, Locale locale) {
    RefreshLocaleAction action = new RefreshLocaleAction(locale);
    dispatch(context, action);
  }

  static refreshTheme(BuildContext context, Color color) {
    ThemeData themeData = ThemeDataManager.buildTheme(color);
    RefreshThemeDataAction action = new RefreshThemeDataAction(themeData);
    dispatch(context, action);
    SpStorage.save(ThemeDataManager.KEY_CURRENT_THEME, color.value);
  }

  static dispatch(BuildContext context, action) {
    Store<GlobalState> store = StoreProvider.of<GlobalState>(context);
    store.dispatch(action);
  }
}
