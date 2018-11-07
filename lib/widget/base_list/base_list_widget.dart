import 'package:flutter/material.dart';
import 'package:simple_flutter/style/global_colors.dart';
import 'package:simple_flutter/style/global_icons.dart';
import 'package:simple_flutter/style/global_text_style.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BaseListWidget extends StatefulWidget {
  BaseListConfig config;
  IndexedWidgetBuilder itemBuilder;

  BaseListWidget(this.config, this.itemBuilder);

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.config.onRefresh == null) {
      widget.config.onRefresh = () {};
    }
    return RefreshIndicator(
      // 使用key做主动刷新
      key: widget.config.refreshKey,
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

  _getDataListLength() {
    if (widget.config.dataList == null || widget.config.dataList.isEmpty) {
      return 0;
    } else {
      return widget.config.dataList.length;
    }
  }

  _getItemCount() {
    int length = _getDataListLength();
    if (widget.config.needRefreshHead) {
      return length > 0 ? length + 2 : length + 1;
    } else {
      if (length == 0) return 1;
      return length > 0 ? length + 1 : length;
    }
  }

  Widget _buildItem(BuildContext context, int index) {
    int length = _getDataListLength();
    bool needRefreshHead = widget.config.needRefreshHead;
    if (!needRefreshHead && index == length && length != 0) {
      // 如果不需要头部，并且数据不为0，当index等于数据长度时(index从0开始)，渲染加载更多Item
      return _buildLoadMoreIndicator();
    } else if (needRefreshHead && index == _getItemCount() - 1 && length != 0) {
      // 如果需要头部，并且数据不为0，当index等于实际渲染长度-1时，渲染加载更多Item
      return _buildLoadMoreIndicator();
    } else if (length == 0) {
      return _buildEmpty();
    } else {
      return widget.itemBuilder(context, index);
    }
  }

  _buildEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height - 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Image.asset(
              GlobalIcons.DEFAULT_ICON,
              width: 70.0,
              height: 70.0,
            ),
            onPressed: () {
              widget.config.refreshKey?.currentState?.show();
            },
          ),
          Container(height: 10.0),
          Text(
            Strings.of(context).empty(),
            style: GlobalTextStyle.theme(context),
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
                      ? SpinKitWave(
                          size: 20.0,
                          color: GlobalColors.theme(context),
                          type: SpinKitWaveType.start)
                      : Container(),
                  Container(width: 10.0),
                  Text(
                      haveMoreData
                          ? Strings.of(context).loadMoreText()
                          : Strings.of(context).empty(),
                      style: GlobalTextStyle.theme(context))
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
  GlobalKey<RefreshIndicatorState> refreshKey;
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
