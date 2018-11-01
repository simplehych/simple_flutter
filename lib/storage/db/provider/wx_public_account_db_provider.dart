import 'package:simple_flutter/storage/db/base_db_provider.dart';
import 'package:sqflite/sqflite.dart';

class WxPublicAccountDbProvider extends BaseDbProvider {
  final String columnId = "id";
  final String columnName = "name";
  final String columnOrder = "order";
  final String columnParentChapterId = "parentChapterId";
  final String columnUserControlSetTop = "userControlSetTop";
  final String columnVisible = "visible";
  final String columnCourseId = "courseId";
  final String columnChildren = "children";

  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;
//  List<String> children;
  int courseId;


  WxPublicAccountDbProvider();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
//      columnId: id,
      columnName: name,
//      columnOrder: order,
//      columnParentChapterId: parentChapterId,
//      columnUserControlSetTop: userControlSetTop,
//      columnVisible: visible,
//      columnCourseId: courseId,
//      columnChildren: children,
    };
    return map;
  }

  WxPublicAccountDbProvider.fromMap(Map map) {
    id = map[columnId];
    name = map[columnName];
    order = map[columnOrder];
    parentChapterId = map[columnParentChapterId];
    userControlSetTop = map[columnUserControlSetTop];
    visible = map[columnVisible];
    courseId = map[columnCourseId];
//    children = map[columnChildren];
  }

  @override
  List<String> otherColumnSqlStr() {
    return [
//      "$columnId",
      "$columnName text not null",
//      "columnOrder",
//      "columnParentChapterId",
//      "columnUserControlSetTop",
//      "columnVisible",
//      "columnCourseId",
//      "columnChildren",
    ];
  }

  @override
  String tableName() {
    return "WxPublicAccount";
  }

  insert(WxPublicAccountDbProvider provider) async {
    Database database = await getDatabase();
    return await database.insert(tableName(), provider.toMap());
  }

  query(String name) async {
    Database database = await getDatabase();
    List<Map> resMaps = await database.query(
      tableName(),
      where: "$columnName = ?",
      whereArgs: [name],
    );

    if (resMaps.length > 0) {
      return WxPublicAccountDbProvider.fromMap(resMaps.first);
    }
    return null;
  }

  @override
  String toString() {
    return 'WxPublicAccountDbProvider{name: $name}';
  }


}
