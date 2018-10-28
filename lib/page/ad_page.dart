import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AdvertisePage extends StatelessWidget {

  static final String sName = "advertise";

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
      builder: (context, store) {
        return Container(
          child: Center(
            child: Text('ad page'),
          ),
        );
      },
    );
  }
}
