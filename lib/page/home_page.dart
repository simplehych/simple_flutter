import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/manager/navigator_manager.dart';
import 'package:simple_flutter/model/home_banner_bean.dart';
import 'package:simple_flutter/model/item_list_bean.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/style/global_icons.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:simple_flutter/utils/toast.dart';
import 'package:simple_flutter/widget/base_list/base_list_state.dart';
import 'package:simple_flutter/widget/base_list/base_list_widget.dart';
import 'package:simple_flutter/widget/icon/user_icon.dart';
import 'package:simple_flutter/widget/item/banner_item.dart';
import 'package:simple_flutter/widget/item/home_item.dart';
import 'package:banner/banner.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends BaseListState<HomePage> {
  List bannerList = List();

  @override
  bool get isRefreshFirst => true;

  @override
  requestData(RequestType type) async {
    // 获取首页列表
    BaseResultData articleListResult =
        await HttpManager.get(Address.getHomeArticles(pageNum));
    ItemListBean articleListRes = ItemListBean.fromJson(articleListResult.data);

    // 获取首页轮播图
    if (pageNum == 0) {
      BaseResultData bannerResult =
          await HttpManager.get(Address.getHomeBanner());

      bannerList = bannerResult.data;
      articleListRes.datas.insert(0, articleListRes.datas.first);
    }
    return articleListRes.datas;
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, i) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).appName()),
          ),
          body: BaseListWidget(defaultConfig, (context, i) {
            ItemBean data = dataList[i];
            if (i == 0) {
              return BannerItem(bannerList);
            } else {
              return HomeItem(data);
            }
          }),
        );
      },
    );
  }
}
