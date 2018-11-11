import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:simple_flutter/event/http_error_event.dart';
import 'package:simple_flutter/http/http_code.dart';
import 'package:simple_flutter/manager/localization/global_localization_delegate.dart';
import 'package:simple_flutter/manager/store_manager.dart';
import 'package:simple_flutter/manager/theme_data_manager.dart';
import 'package:simple_flutter/page/splash_page.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/page/guide_page.dart';
import 'package:simple_flutter/page/main_page.dart';
import 'package:simple_flutter/page/ad_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:simple_flutter/style/global_colors.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:simple_flutter/utils/toast.dart';

/// APP入口
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final Store<GlobalState> reduxStore = new Store<GlobalState>(
    appReducer,
    initialState: GlobalState(
      themeData: ThemeDataManager.defTheme(),
      locale: Locale('zh', 'CH'),
    ),
  );

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: reduxStore,
      child: StoreBuilder<GlobalState>(
        builder: (context, store) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalLocalizationsDelegate.delegate,
            ],
            locale: store.state.locale,
            supportedLocales: [store.state.locale],
            theme: store.state.themeData,
            routes: {
              SplashPage.sName: (context) {
                store.state.platformLocale = Localizations.localeOf(context);
                return SplashPage();
              },
              GuidePage.sName: (context) {
                return BaseLocalWidget(
                  child: GuidePage(),
                );
              },
              AdvertisePage.sName: (context) {
                return BaseLocalWidget(
                  child: AdvertisePage(),
                );
              },
              MainPage.sName: (context) {
                return BaseLocalWidget(
                  child: MainPage(),
                );
              },
            },
          );
        },
      ),
    );
  }
}

class BaseLocalWidget extends StatefulWidget {
  final Widget child;

  BaseLocalWidget({this.child});

  @override
  State<StatefulWidget> createState() {
    return _BaseLocalWidgetState();
  }
}

class _BaseLocalWidgetState extends State<BaseLocalWidget> {
  StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    streamSubscription = HttpCode.eventBus.on<HttpErrorEvent>().listen((event) {
      _handleHttpErrorTip(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (streamSubscription != null) {
      streamSubscription.cancel();
      streamSubscription = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return new Localizations.override(
          context: context,
          locale: store.state.locale,
          child: widget.child,
        );
      },
    );
  }

  _handleHttpErrorTip(int code, String message) {
    switch (code) {
      default:
        Toast.showShort(Strings.of(context).networkErrorUnknown());
        break;
    }
  }
}
