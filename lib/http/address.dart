class Address {
  static const String HOST = "http://wanandroid.com";

  /// 获取公众号列表
  static getWxPubAccounts() {
    return _finalUrl("/wxarticle/chapters/json");
  }

  /// 获取某个公众号历史数据
  static getHistoryOnWxPubAccount(int id, int pageNum) {
    return _finalUrl(
        "/wxarticle/list/${id.toString()}/${pageNum.toString()}/json");
  }

  /// 在某个公众号中搜索历史文章
  static searchHistoryOnWxPubAccount(
      String id, String pageNum, String searchKey) {
    return _finalUrl("/wxarticle/list/$id/$pageNum/json?k=$searchKey");
  }

  /// 获取最新项目
  static getLatestProjects(int pageNum) {
    return _finalUrl("/article/listproject/${pageNum.toString()}/json");
  }

  /// 首页文章列表
  static getHomeArticles(int pageNum) {
    return _finalUrl("/article/list/${pageNum.toString()}/json");
  }

  /// 首页轮播图
  static getHomeBanner() {
    return _finalUrl("/banner/json");
  }

  /// 登录
  /// 参数：username，password
  static login() {
    return _finalUrl("/user/login");
  }

  /// 注册
  /// 参数：username,password,repassword
  static register() {
    return _finalUrl("/user/register");
  }

  /// 退出
  static logout() {
    return _finalUrl("/user/logout/json");
  }

  /// 收藏文章列表
  static collectList(int pageNum) {
    return _finalUrl("/lg/collect/list/${pageNum.toString()}/json");
  }

  /// 收藏站内文章
  static collectInner(int id) {
    return _finalUrl("/lg/collect/list/0/json");
  }

  static _finalUrl(String shortPath) {
    return "$HOST$shortPath";
  }
}
