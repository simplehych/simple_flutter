import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static showShort(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
