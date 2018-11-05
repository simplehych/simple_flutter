import 'package:flutter/material.dart';
import 'package:simple_flutter/widget/base_list/base_list_widget.dart';

abstract class BaseListState<T extends StatefulWidget> extends State<T> {
  bool isLoading = false;
  int pageNum = 0;

  List dataList = new List();
  BaseListConfig config = BaseListConfig();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    config = BaseListConfig(
      dataList: new List(),
      needRefreshHead: false,
      needLoadMore: true,
      refreshKey: refreshIndicatorKey,
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      haveMoreData: true,
    );
    assert(config.dataList != null);
    super.initState();
    if (config.dataList.length == 0) {
//      showRefreshIndicator();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  showRefreshIndicator() {
    refreshIndicatorKey.currentState.show();
  }

  Future<Null> onRefresh() async {
    if (isLoading) return null;
    isLoading = true;

    pageNum = 0;
    List datas = await requestData(RequestType.REFRESH);
    setState(() {
      config.dataList.clear();
      config.dataList.addAll(datas);
      dataList = config.dataList;
    });

    isLoading = false;
    return null;
  }

  Future<Null> onLoadMore() async {
    if (isLoading) return null;
    isLoading = true;

    pageNum++;
    List datas = await requestData(RequestType.REFRESH);
    setState(() {
      if (datas != null) {
        config.dataList.addAll(datas);
      } else {
        config.haveMoreData = false;
      }
      dataList = config.dataList;
    });

    isLoading = false;
    return null;
  }

  requestData(RequestType type);
}

enum RequestType { REFRESH, LOAD_MORE }
