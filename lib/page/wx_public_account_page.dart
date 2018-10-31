import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/model/wx_public_account.dart';
import 'package:simple_flutter/redux/global_state.dart';

class WxPublicAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WxPublicAccountPageState();
  }
}

class _WxPublicAccountPageState extends State<WxPublicAccountPage> {
  List dataList = List();

//  @override
//  void initState() {
//    super.initState();
//  }

//  @override
//  void didChangeDependencies() {
////    fetchData();
//    super.didChangeDependencies();
//  }

  fetchData() async {
    var res = await HttpManager.get(Address.getWxPubAccounts());
    dataList = res.data;
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemBuilder: (context, i) {
              print(dataList);
              if (dataList == null) {
                return Container();
              }
              return Center(
                child: Text("11"),
              );
//              assert(dataList[i] is WxPublicAccount);
//              WxPublicAccount data = dataList[i];
//              return RaisedButton(
//                child: Center(
//                  child: Text(data.name),
//                ),
//                onPressed: () {
//                  Scaffold.of(context).showSnackBar(
//                      SnackBar(content: Text(data.courseId.toString())));
//                },
//              );
            });
      },
    );
  }
}
