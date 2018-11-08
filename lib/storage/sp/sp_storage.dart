import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_flutter/utils/log.dart';

///SharedPreferences存储类
class SpStorage {
  static const String _TAG = "SpStorage";
  static final String keyIsFirstRunApp = "key_is_first_run_app";

  static save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else {
      throw Exception("SpStorage save value type is exception!");
    }
  }

  ///泛型判断有没有更好的办法 ==
  ///有预判的功能？？？？？
  ///以int为例，加了Color的默认值就返回4294967295(0xFFFFFF)?????
  /// eg
  ///  SplashPage
  ///  int colorValue = await SpStorage.get<int>(ThemeDataManager.KEY_CURRENT_THEME);
  ///     int colorValue =  await SpStorage.get<int>(ThemeDataManager.KEY_CURRENT_THEME,defValue: ThemeDataManager.themeColorDefault);
  /// 然后打开下面注释代码查看不同
  ///
  static Future<T> get<T>(String key, {defValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.get(key);
    return value;
//    Log.i(_TAG, "get value: $value");
//    if (T == String) {
//      Log.i(_TAG, "get String");
//      return value ?? defValue ?? "";
//    } else if (T == bool) {
//      Log.i(_TAG, "get bool");
//      return value ?? defValue ?? false;
//    } else if (T == double || T == int) {
//      Log.i(_TAG, "get double||int");
//      return value ?? defValue ?? -1;
//    } else if (T == List) {
//      Log.i(_TAG, "get List");
//      return value ?? defValue ?? [];
//    } else {
//      Log.i(_TAG, "get else");
//      return defValue ?? value ?? "";
//    }
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
