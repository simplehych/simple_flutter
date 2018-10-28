import 'package:flutter/material.dart';
import 'package:simple_flutter/page/guide_page.dart';
import 'package:simple_flutter/page/ad_page.dart';
import 'package:simple_flutter/page/main_page.dart';

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
}
