class Log {
  static final bool _debug = true;

  static i(String tag, String message) {
    if (_debug) {
      print("   $tag $message");
    }
  }
}
