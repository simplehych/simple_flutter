import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/page/wx_public_account_article_page.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/utils/toast.dart';

class WxPublicAccountSearchPage extends SearchDelegate<int> {
  List _recommendData = ["recommend 1", "recommend 2", "other 3"];
  List _historyData = ["history 1", "history 2", "other 3", "44", "55"];

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: "back",
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: "Voice Search",
              icon: Icon(Icons.mic),
              onPressed: () {
                Toast.showShort("TODO: implement voice search");
              },
            )
          : IconButton(
              tooltip: "clear",
              icon: Icon(Icons.clear),
              onPressed: () {
                query = "";
                showSuggestions(context);
              },
            )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    final int searched = int.parse(query);
    return Center(
      child: Text("TODO: implement results"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _recommendData == null
              ? Container()
              : Container(
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: <Widget>[
                      ActionChip(
                        label: Text(_recommendData[0]),
                        onPressed: () {},
                      ),
                      ActionChip(
                        label: Text(_recommendData[1]),
                        onPressed: () {},
                      ),
                      ActionChip(
                        label: Text(_recommendData[2]),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
          _historyData == null
              ? Container()
              : Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.history),
                        title: Text(_historyData[0]),
                      ),
                      ListTile(
                        leading: Icon(Icons.history),
                        title: Text(_historyData[1]),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return StoreProvider.of<GlobalState>(context).state.themeData;
  }
}
