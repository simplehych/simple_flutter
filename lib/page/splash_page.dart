import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/manager/navigator_manager.dart';
import 'package:simple_flutter/manager/store_manager.dart';
import 'package:simple_flutter/manager/theme_data_manager.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/storage/sp/sp_storage.dart';
import 'package:simple_flutter/style/global_colors.dart';
import 'package:simple_flutter/utils/log.dart';

/// 开屏页
class SplashPage extends StatefulWidget {
  static final String sName = "/";

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  static const String _TAG = "_SplashPageState";

  bool hadInitState = false;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Container(
          color: Color(GlobalColors.white),
          child: Center(
            child: Text('splash page'),
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (hadInitState) {
      return;
    }

    hadInitState = true;

    initTheme();
    Future.delayed(
      const Duration(seconds: 2),
      _goPageChoice,
    );
  }

  initTheme() async {
    int colorValue =
        await SpStorage.get<int>(ThemeDataManager.KEY_CURRENT_THEME,defValue: ThemeDataManager.themeColorDefault);

    Log.i(_TAG, "color: $colorValue  blue:${Colors.blue.value}");
    Color color;
    if (colorValue == null) {
      color = ThemeDataManager.themeColorDefault;
    } else {
      color = Color(colorValue);
    }
    StoreManager.refreshTheme(context, color);
  }

  _goPageChoice() async {
    NavigatorManager.goMainPage(context);
//    bool isFirstRunApp = await SpStorage.get<bool>(SpStorage.keyIsFirstRunApp);
//    Log.i(_TAG, 'isFirstRunApp: $isFirstRunApp');
//    if (isFirstRunApp) {
//      //第一次运行app(未进入到首页)，则进入引导页面
//      NavigatorManager.goGuidePage(context);
//    } else {
//      //非第一次运行app，有广告进入广告页面，否则进入主页
//      bool isHaveAd = true;
//      Log.i(_TAG, 'isHaveAd: $isHaveAd');
//      if (isHaveAd) {
//        NavigatorManager.goAdPage(context);
//      } else {
//        NavigatorManager.goMainPage(context);
//      }
//    }
  }
}
