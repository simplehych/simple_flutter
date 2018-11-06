import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_flutter/widget/base_list/base_list_widget.dart';

abstract class BaseListState<T extends StatefulWidget> extends State<T> {
  bool isLoading = false;
  int pageNum = 0;

  List dataList = new List();
  BaseListConfig defaultConfig = BaseListConfig();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    defaultConfig = BaseListConfig(
      dataList: new List(),
      needRefreshHead: false,
      needLoadMore: true,
      refreshKey: refreshIndicatorKey,
      onRefresh: () {
        return onRefresh();
      },
      onLoadMore: onLoadMore,
      haveMoreData: true,
    );

    super.initState();
    if (defaultConfig.dataList.length == 0 && isRefreshFirst) {
      showRefreshIndicator();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  showRefreshIndicator() {
    // 需要延迟？？？否则 refreshIndicatorKey为null？？？
    Future.delayed(Duration(seconds: 0), () {
      refreshIndicatorKey?.currentState?.show();
    });
  }

  Future<Null> onRefresh() async {
    if (isLoading) return null;
    isLoading = true;

    pageNum = 0;
    List datas = await requestData(RequestType.REFRESH);

    Completer completer = Completer();
    completer.complete();
    return completer.future.then((_) {
      isLoading = false;
      setState(() {
        defaultConfig.dataList.clear();
        defaultConfig.dataList.addAll(datas);
        dataList = defaultConfig.dataList;
      });
    });
  }

  Future<Null> onLoadMore() async {
    if (isLoading) return null;
    isLoading = true;

    pageNum++;
    List datas = await requestData(RequestType.REFRESH);
    setState(() {
      if (datas != null) {
        defaultConfig.dataList?.addAll(datas);
      } else {
        defaultConfig.haveMoreData = false;
      }
      dataList = defaultConfig.dataList;
    });

    isLoading = false;
    return null;
  }

  @protected
  bool get isRefreshFirst;

  @protected
  requestData(RequestType type);
}

enum RequestType { REFRESH, LOAD_MORE }
