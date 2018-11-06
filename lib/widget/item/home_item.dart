import 'package:flutter/material.dart';
import 'package:simple_flutter/manager/navigator_manager.dart';
import 'package:simple_flutter/model/item_list_bean.dart';
import 'package:simple_flutter/style/global_text_style.dart';
import 'package:simple_flutter/widget/icon/user_icon.dart';

class HomeItem extends StatelessWidget {
  ItemBean data;

  HomeItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: FlatButton(
        onPressed: () {
          NavigatorManager.goWebViewPage(context, data.title, data.link);
        },
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  UserIcon(),
                  Container(width: 10.0),
                  Expanded(
                      child: Text(data.author, style: GlobalTextStyle.normal)),
                  Text(data.niceDate, style: GlobalTextStyle.small),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                alignment: Alignment.topLeft,
                child: Text(data.title, style: GlobalTextStyle.big),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
