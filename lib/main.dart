import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:simple_flutter/page/splash_page.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/page/guide_page.dart';
import 'package:simple_flutter/page/main_page.dart';
import 'package:simple_flutter/page/ad_page.dart';

/// APP入口
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final reduxStore = new Store<GlobalState>(
    appReducer,
    initialState: GlobalState(
      themeData: ThemeData(
        platform: TargetPlatform.iOS,
      ),
      locale: Locale('zh', 'CH'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: reduxStore,
      child: StoreBuilder<GlobalState>(
        builder: (context, store) {
          return MaterialApp(
            locale: store.state.locale,
            theme: store.state.themeData,
            routes: {
              SplashPage.sName: (context) {
                store.state.platformLocale = Localizations.localeOf(context);
                return SplashPage();
              },
              GuidePage.sName: (context) {
                return GuidePage();
              },
              AdvertisePage.sName: (context) {
                return AdvertisePage();
              },
              MainPage.sName: (context) {
                return MainPage();
              }
            },
          );
        },
      ),
    );
  }
}
