class BaseResultData {
  int errorCode;
  String errorMsg;
  var data;

  @override
  String toString() {
    return 'BaseResultData{errorCode: $errorCode, errorMsg: $errorMsg, data: $data}';
  }
}
