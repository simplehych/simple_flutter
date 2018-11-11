import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.blueAccent
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(20.0, 20.0), Offset(100.0, 100.0), _paint);

    Path path = new Path();
    TextPainter textPainter = new TextPainter();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PainterLineDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PainterLineDemoState();
  }
}

class PainterLineDemoState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("line demo"),
      ),
      body: Container(
        child: CustomPaint(
          painter: LinePainter(),
        ),
      ),
    );
  }
}
