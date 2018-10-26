import 'package:flutter/material.dart';

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
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5.0),
      height: 120.0,
      width: 500.0,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: FlatButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DemoStateWidget())).then((res){});
        },
        child: Text(text ?? "这就是有状态Demo"),
      ),
    );
  }
}
