import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/redux/theme_data_reducer.dart';
import 'package:simple_flutter/style/global_colors.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:simple_flutter/utils/toast.dart';
import 'package:simple_flutter/widget/base_list/base_list_state.dart';
import 'package:simple_flutter/widget/base_list/base_list_widget.dart';
import 'package:simple_flutter/widget/icon/user_icon.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  List dataList;

  @override
  void initState() {
    super.initState();
    dataList = [
      MineTileBean(Icons.art_track, "主题", Icons.chevron_right, () {
        showThemeSelectDialog();
      }),
      MineTileBean(Icons.settings, "设置", Icons.chevron_right, () {
        Toast.showShort("设置");
      }),
      MineTileBean(Icons.settings, "关于", Icons.chevron_right, () {
        Toast.showShort("关于");
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return ListView.builder(
            itemCount: dataList.length + 1,
            itemBuilder: (context, i) {
              if (0 == i) {
                return Container(
                    height: 200.0,
                    color: store.state.themeData.primaryColor,
                    child: Center(
                      child: UserIcon(width: 50.0, height: 50.0),
                    ));
              }
              MineTileBean data = dataList[i - 1];
              return ListTile(
                leading: Icon(data.leading),
                title: Text(data.title),
                trailing: Icon(data.trailing),
                onTap: data.onPressed != null ? data.onPressed : () {},
              );
            });
      },
    );
  }

  showThemeSelectDialog() {
    Store store = StoreProvider.of<GlobalState>(context);

    dispatch(Color color) {
      ThemeData themeData = ThemeData(primarySwatch: color);
      RefreshThemeDataAction refreshThemeDataAction =
          new RefreshThemeDataAction(themeData);
      store.dispatch(refreshThemeDataAction);
    }

    buildItem(Color color, String str) {
      return ListTile(
        leading: Container(
          width: 30.0,
          height: 30.0,
          color: color,
        ),
        title: Text(str),
        onTap: () {
          dispatch(color);
          Navigator.pop(context);
        },
      );
    }

    Map map = new Map();
    map[GlobalColors.primarySwatch] = "default";
    map[Colors.green] = "green";
    map[Colors.brown] = "brown";
    map[Colors.red] = "red";
    map[Colors.amber] = "amber";
    map[Colors.indigo] = "indigo";
    map[GlobalColors.darkSwatch] = "dark";

    List<Widget> children = List();
    map.forEach((key, value) {
      children.add(buildItem(key, value));
    });

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(Strings.of(context).selectTheme()),
            children: children,
          );
        });
  }
}

class MineTileBean {
  IconData leading;
  String title;
  IconData trailing;
  Function onPressed;

  MineTileBean(this.leading, this.title, this.trailing, this.onPressed);
}
