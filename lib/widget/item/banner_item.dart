import 'package:banner/banner.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter/model/home_banner_bean.dart';
import 'package:simple_flutter/style/global_icons.dart';
import 'package:simple_flutter/utils/toast.dart';

class BannerItem extends StatelessWidget {
  List bannerList;

  BannerItem(this.bannerList);

  @override
  Widget build(BuildContext context) {
    return BannerView(
      data: bannerList,
      buildShowView: (index, data) {
        HomeBannerBean d = HomeBannerBean.fromJson(data);
        return Stack(
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: GlobalIcons.DEFAULT_USER_ICON,
              image: d.imagePath,
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  color: Color(0x66000000),
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          d.title,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        "${index % bannerList.length + 1} / ${bannerList.length}",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            ),
          ],
        );
      },
      onBannerClickListener: (index, data) {
        Toast.showShort(index.toString());
      },
    );
  }
}
