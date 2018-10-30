import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// getTemporaryDirectory: 获取应用缓存目录，等同于IOS的NSTemporaryDirectory和Android的getCacheDir方法
/// getApplicationDocumentsDirectory: 获取应用文件目录，类似于IOS的NSDocumentDirectory和Android的AppData目录
/// getExternalStorageDirectory: 这个是存储卡，仅仅在Android平台使用
class FileStorage {
  static const String SEPARATE = "/";

  static Future<String> get _temporaryPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  static Future<String> get _documentsPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _documentsFile(String fileName) async {
    final documentsPath = await _documentsPath;
    return new File('$documentsPath$SEPARATE$fileName');
  }

  static Future<File> saveInDocument(String fileName, String content) async {
    File file = await _documentsFile(fileName);
    return file.writeAsString(content);
  }

  static Future<String> getInDocument(String fileName) async {
    final file = await _documentsFile(fileName);
    return file.readAsString();
  }
}
