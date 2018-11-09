import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/manager/constant.dart';
import 'package:simple_flutter/manager/navigator_manager.dart';
import 'package:simple_flutter/manager/store_manager.dart';
import 'package:simple_flutter/manager/theme_data_manager.dart';
import 'package:simple_flutter/page/animation/home.dart';
import 'package:simple_flutter/page/example/status_bar_example.dart';
import 'package:simple_flutter/page/login_page.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/storage/sp/sp_storage.dart';
import 'package:simple_flutter/style/global_colors.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:simple_flutter/utils/log.dart';
import 'package:simple_flutter/utils/toast.dart';
import 'package:simple_flutter/widget/icon/user_icon.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  static const String _TAG = "_MinePageState";
  String username;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List dataList = [
      MineTileBean(
          Icons.art_track, Strings.of(context).theme(), Icons.chevron_right,
          () {
        showThemeSelectDialog();
      }),
      MineTileBean(
          Icons.settings, Strings.of(context).language(), Icons.chevron_right,
          () {
        showLanguageSelectDialog();
      }),
      MineTileBean(Icons.markunread_mailbox, Strings.of(context).about(),
          Icons.chevron_right, () {
        Toast.showShort(Strings.of(context).about());
      }),
    ];
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: GlobalColors.theme(context),
          ),
          body: ListView.builder(
              itemCount: dataList.length + 1,
              itemBuilder: (context, i) {
                if (0 == i) {
                  return Container(
                      height: 200.0,
                      color: store.state.themeData.primaryColor,
                      child: Center(
                          child: FlatButton(
                        onPressed: () async {
                          bool isLogin =
                              await SpStorage.get<bool>(Constant.KEY_IS_LOGIN);
                          if (isLogin ?? false) {
                            Toast.showShort("已经登录");
                          } else {
                            username = await NavigatorManager.goPage(
                                context, LoginPage());
                            Log.i(_TAG, "username: $username");
                            setState(() {});
                          }
                        },
                        child: Center(
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              UserIcon(width: 50.0, height: 50.0),
                              SizedBox(
                                height: 10.0,
                              ),
                              DefaultTextStyle(
                                style: DefaultTextStyle.of(context).style,
                                child: Text(username ?? "点我点我"),
                              ),
                            ],
                          ),
                        ),
                      )));
                }
                MineTileBean data = dataList[i - 1];
                return ListTile(
                  leading: Icon(data.leading),
                  title: Text(data.title),
                  trailing: Icon(data.trailing),
                  onTap: data.onPressed != null ? data.onPressed : () {},
                );
              }),
        );
      },
    );
  }

  showThemeSelectDialog() {
    buildItem(Color color, String str) {
      return ListTile(
        leading: Container(
          width: 30.0,
          height: 30.0,
          color: color,
        ),
        title: Text(str),
        onTap: () async {
          await StoreManager.refreshTheme(context, color);
          Navigator.pop(context);
        },
      );
    }

    Map map = new Map();
    map[ThemeDataManager.themeColorList[0]] = Strings.of(context).themeBlue();
    map[ThemeDataManager.themeColorList[1]] = Strings.of(context).themeGreen();
    map[ThemeDataManager.themeColorList[2]] = Strings.of(context).themeBrown();
    map[ThemeDataManager.themeColorList[3]] = Strings.of(context).themeRed();
    map[ThemeDataManager.themeColorList[4]] = Strings.of(context).themeAmber();
    map[ThemeDataManager.themeColorList[5]] = Strings.of(context).themeIndigo();
    map[ThemeDataManager.themeColorList[6]] = Strings.of(context).themeDark();

    List<Widget> children = List();
    map.forEach((key, value) {
      children.add(buildItem(key, value));
    });

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(Strings.of(context).selectTheme()),
            children: children,
          );
        });
  }

  showLanguageSelectDialog() {
    const String keyEnglish = "English";
    const String keyChinese = "Chinese";

    dispatch(String language) {
      Locale locale;
      switch (language) {
        case keyEnglish:
          locale = Locale("en", "US");
          break;
        case keyChinese:
          locale = Locale("zh", "CH");
          break;
      }
      StoreManager.refreshLanguage(context, locale);
    }

    buildItem(String str) {
      return ListTile(
        title: Text(str),
        onTap: () {
          dispatch(str);
          Navigator.pop(context);
        },
      );
    }

    Map map = new Map();
    map[keyEnglish] = Strings.of(context).languageEn();
    map[keyChinese] = Strings.of(context).languageEn();

    List<Widget> children = List();
    map.forEach((key, value) {
      children.add(buildItem(key));
    });

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(Strings.of(context).selectTheme()),
            children: children,
          );
        });
  }
}

class MineTileBean {
  IconData leading;
  String title;
  IconData trailing;
  Function onPressed;

  MineTileBean(this.leading, this.title, this.trailing, this.onPressed);
}
