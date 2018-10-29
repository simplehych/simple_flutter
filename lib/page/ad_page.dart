import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/manager/navigator_manager.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/utils/log.dart';

class AdvertisePage extends StatefulWidget {
  static final String sName = "advertise";

  @override
  State<StatefulWidget> createState() {
    return _AdvertisePageState();
  }
}

class _AdvertisePageState extends State<AdvertisePage> {
  static const String _TAG = "_AdvertisePageState";

  int _delaySeconds;
  Timer _countDownTimer;

  @override
  Widget build(BuildContext context) {
    String adImageUrl = "http://pic.58pic.com/58pic/11/84/22/37u58PICzZ6.jpg";
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Stack(
          children: <Widget>[
            FlatButton(
              child: Image.network(adImageUrl),
              onPressed: _jumpToAdDetailPage,
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(10.0),
              child: FlatButton(
                child: Text("跳过 ${_delaySeconds.toString()}"),
                onPressed: _jumpToNextPage,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _countDown(3);
  }

  _countDown(int delays) {
    _delaySeconds = delays;

    _countDownTimer = new Timer.periodic(Duration(seconds: delays), (timer) {
      var tick = timer.tick;
      Log.i(_TAG, "_countDown tick:$tick");

      setState(() {
        _delaySeconds--;
      });

      if (tick == delays) {
        timer.cancel();
        _jumpToNextPage();
      }
    });
  }

  _jumpToNextPage() {
    _cancelTimer();
    NavigatorManager.goMainPage(context);
  }

  _jumpToAdDetailPage() {
    _cancelTimer();
  }

  _cancelTimer() {
    if (_countDownTimer != null && _countDownTimer.isActive) {
      _countDownTimer.cancel();
    }
  }
}
