import 'package:simple_flutter/model/wx_public_account.dart';
import 'package:simple_flutter/storage/db/base_db_provider.dart';
import 'package:simple_flutter/utils/log.dart';
import 'package:sqflite/sqflite.dart';

class WxPublicAccountDbProvider extends BaseDbProvider {
  static const String _TAG = "WxPublicAccountDbProvider";

  final String columnId = "wxid";
  final String columnName = "name";
  final String columnOrder = "order";
  final String columnParentChapterId = "parentChapterId";
  final String columnUserControlSetTop = "userControlSetTop";
  final String columnVisible = "visible";
  final String columnCourseId = "courseId";
  final String columnChildren = "children";

  int id;
  String name;
  String order;
  String parentChapterId;
  String userControlSetTop;
  String visible;

//  List<dynamic> children;
  String courseId;

  WxPublicAccountDbProvider();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnId: id,
      columnName: name,
//      columnOrder: order,
      columnParentChapterId: parentChapterId,
      columnUserControlSetTop: userControlSetTop,
      columnVisible: visible,
      columnCourseId: courseId,
//      columnChildren: children,
    };
    return map;
  }

  WxPublicAccountDbProvider.fromMap(Map map) {
    id = map["id"];
    name = map[columnName];
//    order = map[columnOrder];
    parentChapterId = map[columnParentChapterId].toString();
    userControlSetTop = map[columnUserControlSetTop].toString();
    visible = map[columnVisible].toString();
    courseId = map[columnCourseId].toString();
//    children = map[columnChildren];
  }

  @override
  List<String> otherColumnSqlStr() {
    return [
      "$columnId",
      "$columnName",
//      "$columnOrder",
      "$columnParentChapterId",
      "$columnUserControlSetTop",
      "$columnVisible",
      "$columnCourseId",
//      "$columnChildren",
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
      Log.i(_TAG, "resMaps: ${resMaps.first.toString()}");
      return WxPublicAccountDbProvider.fromMap(resMaps.first);
    }
    return null;
  }

  @override
  String toString() {
    return 'WxPublicAccountDbProvider{columnOrder: $columnOrder, id: id, name: $name, order: $order, parentChapterId: $parentChapterId, userControlSetTop: $userControlSetTop, visible: $visible, children: children}';
  }
}
