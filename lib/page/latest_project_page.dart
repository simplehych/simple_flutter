import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/manager/navigator_manager.dart';
import 'package:simple_flutter/model/item_list_bean.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/style/global_text_style.dart';
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
  bool get isRefreshFirst => true;

  @override
  requestData(RequestType type) async {
    BaseResultData result =
        await HttpManager.get(Address.getLatestProjects(pageNum));
    ItemListBean res = ItemListBean.fromJson(result.data);
    return res.datas;
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(builder: (context, store) {
      return BaseListWidget(
        defaultConfig,
        (context, i) {
          ItemBean data = dataList[i] as ItemBean;
          return Card(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data.title,
                            style: GlobalTextStyle.big,
                            maxLines: 2,
                          ),
                          Container(
                            height: 10.0,
                          ),
                          Text(
                            data.desc,
                            style: GlobalTextStyle.normal,
                            maxLines: 3,
                          ),
                          Container(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                data.niceDate,
                                style: GlobalTextStyle.small,
                              ),
                              Container(
                                width: 10.0,
                              ),
                              Text(
                                data.author,
                                style: GlobalTextStyle.small,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Image.network(
                      data.envelopePic,
                      fit: BoxFit.cover,
                      width: 70.0,
                    ),
                  ],
                ),
              ),
              onTap: () {
                NavigatorManager.goWebViewPage(context, data.title, data.link);
              },
            ),
          );
        },
      );
    });
  }
}
