import 'package:flutter/material.dart';
import 'package:simple_flutter/page/guide_page.dart';
import 'package:simple_flutter/page/ad_page.dart';
import 'package:simple_flutter/page/main_page.dart';
import 'package:simple_flutter/page/web_view_page.dart';

class NavigatorManager {
  /// 引导页面
  static goGuidePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, GuidePage.sName);
  }

  /// 广告页面
  static goAdPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, AdvertisePage.sName);
  }

  /// 主页面
  static goMainPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, MainPage.sName);
  }

  /// webview页面
  static goWebViewPage(BuildContext context, String title, String link) {
    goPage(context, WebViewPage(title, link));
  }

  static Future goPage(BuildContext context, Widget page) async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }
}
