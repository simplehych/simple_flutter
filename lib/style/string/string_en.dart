import 'package:simple_flutter/style/string/string_base.dart';

class StringEn extends StringBase {
  @override
  String networkErrorUnknown() {
    return "Http unknown error";
  }

  @override
  String empty() {
    return "Empty";
  }

  @override
  String loadMoreText() {
    return "loading...";
  }

  @override
  String noMoreData() {
    return "no more data";
  }
}
