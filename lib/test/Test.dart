import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  }
}

class TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}

class FutureTest {
  test() {
    Future.wait([expensiveA(), expensiveB(), expensiveC()])
        .then((List responses) {});
  }

  Future<String> expensiveA() async {
    return "";
  }

  Future<String> expensiveB() async {
    return "";
  }

  Future<String> expensiveC() async {
    return "";
  }

  wait() {

  }


}
