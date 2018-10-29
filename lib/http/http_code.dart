import 'package:event_bus/event_bus.dart';
import 'package:simple_flutter/event/http_error_event.dart';
import 'package:simple_flutter/utils/log.dart';

class HttpCode {
  static const _TAG = "HttpCode";
  static const NETWORK_ERROR = -1;
  static const NETWORK_TIMEOUT = -2;
  static const NETWORK_JSON_EXCEPTION = -3;
  static const SUCCESS = 200;
  static final EventBus eventBus = new EventBus();

  static handleException(int code, String message, [bool noTip]) {
    if (!noTip) {
      eventBus.fire(new HttpErrorEvent(code, message));
    }
    Log.i(_TAG, "handleException code:$code message:$message");
    return message;
  }
}
