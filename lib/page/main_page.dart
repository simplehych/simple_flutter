import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/storage/sp_storage.dart';

class MainPage extends StatefulWidget {
  static final String sName = "main";

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    //修改第一次运行app标记
    SpStorage.save(SpStorage.keyIsFirstRunApp, false);
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Container(
          child: Center(
            child: Text('main page'),
          ),
        );
      },
    );
  }
}
