class Address {
  static const String HOST = "http://wanandroid.com";

  /// 获取公众号列表
  static getWxPubAccounts() {
    String shortPath = "/wxarticle/chapters/json";
    return "$HOST$shortPath";
  }

  /// 获取某个公众号历史数据
  static getHistoryOnWxPubAccount(String id, String pageNum) {
    String shortPath = "/wxarticle/list/$id/$pageNum/json";
    return "$HOST$shortPath";
  }

  /// 在某个公众号中搜索历史文章
  static searchHistoryOnWxPubAccount(
      String id, String pageNum, String searchKey) {
    String shortPath = "/wxarticle/list/$id/$pageNum/json?k=$searchKey";
    return "$HOST$shortPath";
  }

  /// 获取最新项目
  static getLatestProjects(String pageNum){
    String shortPath = "/article/listproject/$pageNum/json";
    return "$HOST$shortPath";
  }
}
