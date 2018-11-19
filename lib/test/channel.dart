import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MethodChannelWidgetState();
  }
}

class _MethodChannelWidgetState extends State<MethodChannelWidget> {
  static const methodChannel =
      MethodChannel("com.simple.simpleflutter/android");
  static const eventChannelNetChanged =
      EventChannel("com.simple.simpleflutter/netchanged");

  String netChangeStr = "点我获取当前网络状态";

  @override
  void initState() {
    super.initState();
    eventChannelNetChanged.receiveBroadcastStream().listen((event) {
      setState(() {
        netChangeStr = event;
      });
    }, onError: (error) {
      setState(() {
        netChangeStr = "网络状态获取失败";
      });
    });
  }

  /// 获取网络状态
  Future<String> isNetConnection() async {
    bool isConnect;
    try {
      isConnect = await methodChannel.invokeMethod("netConnection");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (isConnect) {
      return "连接";
    }
    return "无连接";
  }

  /// 调用android平台的Toast
  showToast(String msg) async {
    try {
      await methodChannel.invokeMethod("showToast", {"msg": msg});
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  /// 获取android平台的信息
  Future<String> getAndroidTime() async {
    String time;
    try {
      time = await methodChannel.invokeMethod("getAndroidTime");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("platformChannels"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
              child: Text("点我toast"),
              onPressed: () {
                showToast("我是android系统的toast");
              }),
          RaisedButton(
            child: Text("点我获取android时间"),
            onPressed: () {
              getAndroidTime().then((time) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(time ?? "获取失败")));
              });
            },
          ),
          RaisedButton(
            child: Text(netChangeStr),
            onPressed: () {
              isNetConnection().then((str) {
                showToast(str);
              });
            },
          ),
        ],
      ),
    );
  }
}
