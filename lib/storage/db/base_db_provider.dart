import 'package:simple_flutter/storage/db/db_storage_manager.dart';
import 'package:simple_flutter/utils/log.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDbProvider {
  static const String _TAG = "BaseDbProvider";
  final String _primaryId = "_id";

  getDatabase() async {
    Database database = await DbStorageManager.getDatabase();
    bool exist = await DbStorageManager.isTableExist(database, tableName());
    if (!exist) {
      String sqlStr = '''
        create table ${tableName()}
        (
        $_primaryId integer primary key autoincrement,
        ${_getTableSqlString()}
        )
      ''';
      Log.i(_TAG, "sqlStr: $sqlStr");
      await database.execute(sqlStr);
    }
    return database;
  }

  String _getTableSqlString() {
    List<String> list = otherColumnSqlStr();
    StringBuffer sb = new StringBuffer();
    list.forEach((element) {
      sb.write(element);
      sb.write(",");
    });
    var res = sb.toString();
    if (res != null && res.endsWith(",")) {
      res = res.substring(0, res.length - 1);
    }
    return res;
  }

  String tableName();

  List<String> otherColumnSqlStr();
}
