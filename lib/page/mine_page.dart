import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/redux/theme_data_reducer.dart';
import 'package:simple_flutter/utils/toast.dart';
import 'package:simple_flutter/widget/base_list/base_list_state.dart';
import 'package:simple_flutter/widget/base_list/base_list_widget.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends BaseListState<MinePage> {
  BaseListConfig config;

  @override
  bool get isRefreshFirst => true;

  @override
  requestData(RequestType type) {
    var list = List.generate(5, (index) {
      switch (index) {
        case 0:
          return MineTileBean(Icons.add, "主题", Icons.chevron_right, () {
            List colors = [Colors.black, Colors.green];
            showDialog(
                context: context,
                builder: (context) {
                  return FlatButton(
                    child: Text("dianwo"),
                    onPressed: () {
                      var themeData = new ThemeData(
                          primarySwatch: Colors.brown,
                          platform: TargetPlatform.iOS);
                      var refreshThemeDataAction =
                          new RefreshThemeDataAction(themeData);
                      StoreProvider.of<GlobalState>(context)
                          .dispatch(refreshThemeDataAction);
                    },
                  );
                });
          });
        case 1:
          return MineTileBean(Icons.add, "设置", Icons.chevron_right, null);
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, i) {
        return BaseListWidget(
          defaultConfig,
          (context, i) {
            MineTileBean data = dataList[i];
            return ListTile(
              leading: Icon(data.leading),
              title: Text(data.title),
              trailing: Icon(data.trailing),
              onTap: data.onPressed != null ? data.onPressed : () {},
            );
          },
        );
      },
    );
  }
}

class MineTileBean {
  IconData leading;
  String title;
  IconData trailing;
  Function onPressed;

  MineTileBean(this.leading, this.title, this.trailing, this.onPressed);
}
