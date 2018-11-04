import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/redux/global_state.dart';

class WxPublicAccountSearchPage extends SearchDelegate<int> {
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
              onPressed: () {},
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
    return Center(child: Text("TODO: implement results"),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("buildSuggestions"),
    );
  }
}
