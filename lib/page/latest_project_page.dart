import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/widget/base_list/base_list_state.dart';
import 'package:simple_flutter/widget/base_list/base_list_widget.dart';

class LatestProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LatestProjectPageState();
  }
}

class LatestProjectPageState extends BaseListState<LatestProjectPage> {
  @override
  requestData(RequestType type) async {
    BaseResultData result =
        await HttpManager.get(Address.getHomeArticles(pageNum));
    var res = result.data;
    return res["datas"];
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return new Scaffold(
          appBar: AppBar(
            title: Text("Latest Project", overflow: TextOverflow.ellipsis),
          ),
          body: BaseListWidget(
            (context, i) {
              return Text(dataList[i]["title"]);
            },
            config,
          ),
        );
      },
    );
  }
}
