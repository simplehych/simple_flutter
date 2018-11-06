import 'package:simple_flutter/style/string/string_base.dart';

class StringZh extends StringBase {
  @override
  String networkErrorUnknown() {
    return "其他异常";
  }

  @override
  String empty() {
    return "目前什么都没有";
  }

  @override
  String loadMoreText() {
    return "加载更多中...";
  }

  @override
  String noMoreData() {
    return "没有更多数据";
  }

  @override
  String selectTheme() {
    return "选择主题";
  }
}
