import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/http_manager.dart';
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

  @override
  void initState() {
    super.initState();
    //修改第一次运行app标记
    SpStorage.save(SpStorage.keyIsFirstRunApp, false);
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Container(
          child: Center(
              child: FlatButton(
            child: Text('main page'),
            onPressed: () async {
              var map2 = {"name": "jack", "mood": "I am happy"};
              UserDbProvider userProvider = UserDbProvider.from(map2);
              await userProvider.delete("jack");
              await userProvider.insert(userProvider);
              UserDbProvider dbUser = await userProvider.query("jack");
              Log.i(_TAG, "dbUser: ${dbUser.toMap().toString()}");
            },
          )),
        );
      },
    );
  }
}
