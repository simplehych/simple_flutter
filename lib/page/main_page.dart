import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/storage/sp_storage.dart';

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
//              String getUrl = "http://wanandroid.com/wxarticle/chapters/json ";
//              var getRes = await HttpManager.get(getUrl);
              String postUrl = "http://www.wanandroid.com/article/query/0/json";
              var postRes = await HttpManager.post(postUrl, params: {"k": "1"},needFormData: true);
//              String postUrl = "http://www.wanandroid.com/lg/uncollect_originId/2333/json";
//              var postRes = await HttpManager.post(postUrl);
//              Log.i(_TAG, "res: $getRes");
            },
          )),
        );
      },
    );
  }
}
