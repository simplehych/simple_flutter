import 'package:flutter/material.dart';
import 'package:simple_flutter/style/global_icons.dart';
import 'package:simple_flutter/style/global_text_style.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BaseListWidget extends StatefulWidget {
  BaseListConfig config;
  IndexedWidgetBuilder itemBuilder;

  BaseListWidget(this.itemBuilder, this.config);

  @override
  State<StatefulWidget> createState() {
    return _BaseListWidgetState();
  }
}

class _BaseListWidgetState extends State<BaseListWidget> {
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    /// 滑动监听
    _scrollController.addListener(() {
      double pixels2 = _scrollController.position.pixels;
      double maxScrollExtent2 = _scrollController.position.maxScrollExtent;

      // 滑到底部，触发加载更多回调
      if (pixels2 == maxScrollExtent2) {
        if (widget.config.needLoadMore && widget.config.haveMoreData) {
          widget.config.onLoadMore?.call();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // 使用key做主动刷新
//      key: widget.config.refreshKey,
      // 下拉刷新，有返回结果决定刷新动画结束，接收到则刷新动画结束，如果是异步且没有返回则马上结束动画
      onRefresh: widget.config.onRefresh,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: _getItemCount(),
        itemBuilder: _buildItem,
      ),
    );
  }

  _getItemCount() {
    int length = widget.config.dataList.length;
    if (widget.config.needRefreshHead) {
      return length > 0 ? length + 2 : length + 1;
    } else {
      if (length == 0) return 1;
      return length > 0 ? length + 1 : length;
    }
  }

  Widget _buildItem(BuildContext context, int index) {
    int length = widget.config.dataList.length;
    bool needRefreshHead = widget.config.needRefreshHead;
    if (needRefreshHead && index == length && length != 0) {
      return _buildLoadMoreIndicator();
    } else if (needRefreshHead && index == _getItemCount() - 1 && length != 0) {
      return _buildLoadMoreIndicator();
    } else if (length == 0) {
      return _buildEmpty();
    } else {
      return widget.itemBuilder(context, index);
    }
  }

  _buildEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Image.asset(
              GlobalIcons.DEFAULT_ICON,
              width: 70.0,
              height: 70.0,
            ),
            onPressed: () {},
          ),
          Text(
            Strings.of(context).empty(),
            style: GlobalTextStyle.normal,
          ),
        ],
      ),
    );
  }

  _buildLoadMoreIndicator() {
    bool haveMoreData = widget.config.haveMoreData;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: !widget.config.needLoadMore
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  haveMoreData
                      ? SpinKitRotatingCircle(itemBuilder: (context, i) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                                color: i.isEven ? Colors.red : Colors.green),
                          );
                        })
                      : Container(),
                  Container(width: 5.0),
                  Text(
                      haveMoreData
                          ? Strings.of(context).loadMoreText()
                          : Strings.of(context).empty(),
                      style: GlobalTextStyle.normal),
                ],
              ),
      ),
    );
  }
}

class BaseListConfig {
  List dataList = new List();
  bool needRefreshHead = false;
  bool needLoadMore = true;
  Key refreshKey;
  RefreshCallback onRefresh;
  RefreshCallback onLoadMore;
  bool haveMoreData = true;

  BaseListConfig(
      {this.dataList,
      this.needRefreshHead,
      this.needLoadMore,
      this.refreshKey,
      this.onRefresh,
      this.onLoadMore,
      this.haveMoreData});
}
