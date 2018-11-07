import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/model/wx_public_account.dart';
import 'package:simple_flutter/page/home_page.dart';
import 'package:simple_flutter/page/latest_project_page.dart';
import 'package:simple_flutter/page/mine_page.dart';
import 'package:simple_flutter/page/wx_public_account_page.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/storage/db/provider/user_db_provider.dart';
import 'package:simple_flutter/storage/sp/sp_storage.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:simple_flutter/utils/log.dart';

class MainPage extends StatefulWidget {
  static final String sName = "main";

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  static const String _TAG = "_MainPageState";

  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    //修改第一次运行app标记
//    SpStorage.save(SpStorage.keyIsFirstRunApp, false);
  }

  @override
  Widget build(BuildContext context) {
    _navigationViews(themeColor) {
      return <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.grey),
          title: Text(Strings.of(context).mainTabHome()),
          activeIcon: Icon(Icons.home, color: themeColor),
          backgroundColor: Colors.brown,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment, color: Colors.grey),
          title: Text(Strings.of(context).mainTabLatest()),
          activeIcon: Icon(Icons.assignment, color: themeColor),
          backgroundColor: Colors.brown,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallpaper, color: Colors.grey),
          title: Text(Strings.of(context).mainTabWx()),
          activeIcon: Icon(Icons.wallpaper, color: themeColor),
          backgroundColor: Colors.brown,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle, color: Colors.grey),
          title: Text(Strings.of(context).mainTabMine()),
          activeIcon: Icon(Icons.account_circle, color: themeColor),
          backgroundColor: Colors.brown,
        ),
      ];
    }

    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        Color themeColor = store.state.themeData.primaryColor;
        return WillPopScope(
          child: Scaffold(
            body: IndexedStack(
              children: <Widget>[
                HomePage(),
                LatestProjectPage(),
                WxPublicAccountPage(),
                MinePage(),
              ],
              index: _tabIndex,
            ),
            bottomNavigationBar: Container(
              child: BottomNavigationBar(
                items: _navigationViews(themeColor),
                type: BottomNavigationBarType.fixed,
                currentIndex: _tabIndex,
                fixedColor: themeColor,
                onTap: (index) {
                  setState(() {
                    _tabIndex = index;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
