import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/manager/navigator_manager.dart';
import 'package:simple_flutter/model/item_list_bean.dart';
import 'package:simple_flutter/page/wx_public_account_search_page.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/utils/log.dart';
import 'package:simple_flutter/utils/toast.dart';

class WxPublicAccountArticlePage extends StatefulWidget {
  int wxPublicAccountId;
  String wxPublicAccountName;

  WxPublicAccountArticlePage(this.wxPublicAccountId, this.wxPublicAccountName);

  @override
  State<StatefulWidget> createState() {
    return WxPublicAccountArticlePageState();
  }
}

class WxPublicAccountArticlePageState
    extends State<WxPublicAccountArticlePage> {
  static const String _TAG = "_WxPublicAccountArticlePageState";

  List<ItemBean> dataList = new List();
  int pageNum = 0;
  ScrollController _controller = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicator = GlobalKey();
   final WxPublicAccountSearchPage _searchDelegate = WxPublicAccountSearchPage();

  @override
  void initState() {
    super.initState();
    Log.i(_TAG, "initState");
    _controller.addListener(() {
      var maxScrollExtent2 = _controller.position.maxScrollExtent;
      var pixels2 = _controller.position.pixels;
      if (maxScrollExtent2 == pixels2) {
        fetchData();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Log.i(_TAG, "didChangeDependencies");
    fetchData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  fetchData() async {
    var res = await HttpManager.get(
        Address.getHistoryOnWxPubAccount(widget.wxPublicAccountId, pageNum));
    ItemListBean r = ItemListBean.fromJson(res.data);
    setState(() {
      if (pageNum == 0) {
        dataList.clear();
      }
      Log.i(_TAG, "WxPublicAccountArticle: ${r.toString()}");
      dataList.addAll(r.datas);
      pageNum++;
    });
    return null;
//    Completer completer = Completer();
//    Timer(Duration(seconds: 3), () => completer.complete(null));
//    return completer.future.then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.wxPublicAccountName),
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.all(10.0),
                icon: Icon(Icons.search),
                onPressed: () async {
                  final int select = await showSearch(
                    context: context,
                    delegate: _searchDelegate,
                  );
                },
              ),
            ],
          ),
          body: (dataList == null || dataList.isEmpty)
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  key: _refreshIndicator,
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      var title = dataList[i].title;
                      var date = dataList[i].niceDate;
                      var tags = dataList[i].tags;
                      var link = dataList[i].link;

                      return Card(
                        color: Colors.brown,
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Wrap(
                                        alignment: WrapAlignment.start,
                                        spacing: 20.0,
                                        runSpacing: 5.0,
                                        children: <Widget>[
                                          Text(
                                            tags.first?.name,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )),
                                      Text(
                                        date,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            NavigatorManager.goWebViewPage(
                                context, title, link);
                          },
                        ),
                      );
                    },
                    itemCount: dataList.length,
                    controller: _controller,
                    physics: AlwaysScrollableScrollPhysics(),
                  ),
                  onRefresh: () {
                    pageNum = 0;
                    return fetchData();
                  },
                ),
        );
      },
    );
  }
}
