import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:simple_flutter/manager/navigator_manager.dart';
import 'package:simple_flutter/redux/global_state.dart';

class GuidePage extends StatelessWidget {
  static final String sName = "guide";

  final pages = [
    new PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      iconImageAssetPath: 'assets/air-hostess.png',
      iconColor: null,
      bubbleBackgroundColor: null,
      body:
          'Haselfree  booking  of  flight  tickets  with  full  refund  on  cancelation',
      title: 'Flights',
      mainImageAssetPath: 'assets/airplane.png',
    ),
    new PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      iconImageAssetPath: 'assets/air-hostess.png',
      iconColor: null,
      bubbleBackgroundColor: null,
      body:
          'Haselfree  booking  of  flight  tickets  with  full  refund  on  cancelation',
      title: 'Flights',
      mainImageAssetPath: 'assets/airplane.png',
    ),
    new PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      iconImageAssetPath: 'assets/air-hostess.png',
      iconColor: null,
      bubbleBackgroundColor: null,
      body:
          'Haselfree  booking  of  flight  tickets  with  full  refund  on  cancelation',
      title: 'Flights',
      mainImageAssetPath: 'assets/airplane.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return IntroViewsFlutter(
          pages,
          showSkipButton: false,
          pageButtonsColor: Colors.white,
          onTapDoneButton: () {
//            Navigator.pop(context);
            NavigatorManager.goMainPage(context);
          },
        ); //IntroViewsFlutter
      },
    );
  }
}
