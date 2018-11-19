
import 'package:flutter/material.dart';
import 'package:simple_flutter/test/channel.dart';

void main() => runApp(TestWidget());

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MethodChannelWidget(),
        ),
      ),
    );
  }
}

class SliverWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SliverState();
  }
}

class SliverState extends State<SliverWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    String headImageUrl =
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg";
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("标题"),
                  background: Image.network(
                    headImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverPersistentHeaderDelegate(
                  TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      controller: TabController(length: 2, vsync: this),
                      tabs: <Widget>[
                        Tab(text: "Tab 1"),
                        Tab(text: "Tab 2"),
                      ]),
                ),
              ),
            ];
          },
          body: Center(
            child: ListView.builder(
                itemCount: 40,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.style),
                    title: Text("list title $index"),
                    onTap: () {},
                  );
                }),
          )),
    );
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverPersistentHeaderDelegate(this._tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class DemoStateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoStateWidgetState();
  }
}

class DemoStateWidgetState extends State<DemoStateWidget> {
  String text;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        text = "这就变了数值";
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(5.0),
        height: 120.0,
        width: 500.0,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: FlatButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DemoStateWidget()))
                .then((res) {});
          },
          child: Text(text ?? "这就是有状态Demo"),
        ),
      ),
    );
  }
}
