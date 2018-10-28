import 'package:shared_preferences/shared_preferences.dart';

///SharedPreferences存储类
class SpStorage {
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
  static Future<T> get<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.get(key);
    if (T == String) {
      return value ?? "";
    } else if (T == bool) {
      return value ?? false;
    } else if (T == double || T == int) {
      return value ?? -1;
    } else if (T == List) {
      return value ?? [];
    } else {
      return value ?? "";
    }
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
