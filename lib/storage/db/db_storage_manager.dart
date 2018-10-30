import 'package:path/path.dart';
import 'package:simple_flutter/utils/log.dart';
import 'package:sqflite/sqflite.dart';

class DbStorageManager {
  static const String _TAG = "DbStorageManager";
  static const String _DB_NAME = "simple_flutter.db";
  static const int _DB_VERSION = 1;

  static Database _database;

  static getDatabase() async {
    if (_database != null) {
      // 针对每个用户创建不同的库，以下代码待验证
      if (!await isCurUserDatabase()) {
        close();
        await _createDatabase(await _getDatabasePath());
      }
    } else {
      await _createDatabase(await _getDatabasePath());
    }
    return _database;
  }

  static _createDatabase(String path) async {
    _database = await openDatabase(
      path,
      version: _DB_VERSION,
      onCreate: (database, version) {},
    );
  }

  static isTableExist(Database database, String tableName) async {
    Log.i(_TAG, "isTableExist tableName: $tableName  database: $database");
    var res = await database.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  static close() {
    _database?.close();
    _database = null;
  }

  static _getDatabasePath() async {
    String finalDbPath = "";
    String curUsername = await _getCurUsername();
    String databasesPath = await getDatabasesPath();
    String defaultDbName = _DB_NAME;

    if (curUsername != null) {
      String userDbName = '${curUsername}_$defaultDbName';
      finalDbPath = join(databasesPath, userDbName);
    } else {
      finalDbPath = join(databasesPath, defaultDbName);
    }
    Log.i(_TAG, "_getDatabasePath finalDbPath: $finalDbPath");
    return finalDbPath;
  }

  static isCurUserDatabase() async {
    String curUsername = await _getCurUsername();
    if (curUsername == null) {
      return false;
    }
    String path = _database.path;
    List<String> split2 = split(path);
    String curDbName = split2[split2.length - 1];
    return curDbName.contains(curUsername);
  }

  static _getCurUsername() async {
    //TODO 获取用户信息
    return "jack";
  }
}
