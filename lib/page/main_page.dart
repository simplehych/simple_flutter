import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/model/wx_public_account.dart';
import 'package:simple_flutter/page/wx_public_account_page.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/storage/db/provider/user_db_provider.dart';
import 'package:simple_flutter/storage/sp/sp_storage.dart';
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
    List<BottomNavigationBarItem> _navigationViews = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.grey),
        title: Text("home"),
        activeIcon: Icon(Icons.home, color: Colors.blue),
        backgroundColor: Colors.brown,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.wallpaper, color: Colors.grey),
        title: Text("wx"),
        activeIcon: Icon(Icons.wallpaper, color: Colors.blue),
        backgroundColor: Colors.brown,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle, color: Colors.grey),
        title: Text("mine"),
        activeIcon: Icon(Icons.account_circle, color: Colors.blue),
        backgroundColor: Colors.brown,
      ),
    ];

    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              title: Text("wanandroid"),
            ),
            body: IndexedStack(
              children: <Widget>[
                Center(
                  child: Text("home"),
                ),
                WxPublicAccountPage(),
//              Center(),
                Center(
                  child: Text("mine"),
                ),
              ],
              index: _tabIndex,
            ),
            bottomNavigationBar: Container(
              child: BottomNavigationBar(
                items: _navigationViews,
                type: BottomNavigationBarType.fixed,
                currentIndex: _tabIndex,
                fixedColor: Colors.blue,
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
