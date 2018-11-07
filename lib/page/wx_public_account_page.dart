import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/model/wx_public_account.dart';
import 'package:simple_flutter/page/animation/home.dart';
import 'package:simple_flutter/page/wx_public_account_article_page.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/storage/db/provider/wx_public_account_db_provider.dart';
import 'package:simple_flutter/utils/log.dart';

class WxPublicAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WxPublicAccountPageState();
  }
}

class _WxPublicAccountPageState extends State<WxPublicAccountPage> {
  static const String _TAG = "_WxPublicAccountPageState";

  List dataList;

  @override
  void initState() {
    super.initState();
    Log.i(_TAG, "initState");
    fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Log.i(_TAG, "didChangeDependencies");
  }

  fetchData() async {
    var res = await HttpManager.get(Address.getWxPubAccounts());
    dataList = res.data;
    for (var data in dataList) {
      WxPublicAccountDbProvider provider = new WxPublicAccountDbProvider();
      var insertId = await provider.insert(WxPublicAccountDbProvider.fromMap(data));

      var query = await provider.query("鸿洋");
      Log.i(_TAG, "rawQuery: $query");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        if (dataList == null) {
          Log.i(_TAG, "ListView.builder dataList==null");
          return Container();
        }
        return AnimationDemoHome(dataList);
//        return ListView.builder(
//          padding: EdgeInsets.all(16.0),
//          itemBuilder: (context, i) {
//            assert(dataList != null);
//            Log.i(_TAG,
//                "ListView.builder dataList[$i] ${dataList[i].toString()}");
//            WxPublicAccount data = WxPublicAccount.fromJson(dataList[i]);
//            return RaisedButton(
//              child: Center(
//                child: Text(data.name),
//              ),
//              onPressed: () {
//                Navigator.of(context).push(MaterialPageRoute(builder: (context){
//                  return WxPublicAccountArticlePage(data.id,data.name);
//                }));
//              },
//            );
//          },
//          itemCount: dataList.length,
//        );
      },
    );
  }
}
