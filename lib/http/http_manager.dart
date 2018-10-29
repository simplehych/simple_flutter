import 'dart:_http';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:simple_flutter/utils/log.dart';

class HttpManager {
  static final String _tag = "HttpManager";

  static const int TIMEOUT_CONNECT = 5000;
  static const int TIMEOUT_RECEIVE = 3000;

  static const String CONTENT_TYPE_JSON = "application/json";
  static const String CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  static const String METHOD_GET = "GET";
  static const String METHOD_POST = "POST";
  static const String METHOD_PUT = "PUT";
  static const String METHOD_DELETE = "DELETE";
  static const String METHOD_PATCH = "PATCH";
  static const String METHOD_HAND = "HAND";

  static get(String url) {
    Dio dio = Dio();
  }

  static post(String url) {}

  static _request(String url, Function callback,
      {String method,
      Map<String, dynamic> params,
      Function errorCallback}) async {
    Log.i(_tag, '''
    _request info
    method: ${method ?? "null"}  url: $url
    params: ${params.toString() ?? "params is null"}
    ---
    ''');

    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (ConnectivityResult.none == connectivityResult) {
      Log.i(_tag, "_request connectivityResult none");
      return;
    }

    //如果方法类型统一转换成大写，如果为空默认为GET请求
    if (method != null) {
      method = method.toUpperCase();
    } else {
      method = METHOD_GET;
    }

    ///配置网络请求信息
    Options options = Options();
    //连接服务器超时时间，单位毫秒
    options.connectTimeout = TIMEOUT_CONNECT;
    //响应流上前后俩次接受到数据的间隔，单位毫秒
    options.receiveTimeout = TIMEOUT_RECEIVE;
    //请求方法类型
    options.method = method;
    if (_checkParamsNull(params) && params is Map) {
      //contentType
      options.contentType = ContentType.parse(CONTENT_TYPE_JSON);
      //接受响应数据类型
      options.responseType = ResponseType.JSON;
    } else {
      options.contentType = ContentType.parse(CONTENT_TYPE_FORM);
      options.responseType = ResponseType.PLAIN;
    }

    //如果是Get方法，将请求参数拼接到地址后，并将参数置为null
    if (METHOD_GET == method && _checkParamsNull(params)) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((k, v) {
        sb.write("$k=$v");
        sb.write("&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
      params = null;
    }

    //dio请求流：请求拦截器 >> 请求转换器 >> 发起请求 >> 响应转换器 >> 响应拦截器 >> 最终结果
    Dio dio = new Dio(options);

    /// 拦截器
    dio.interceptor.request.onSend = (Options options) {
      return options;
      //1. 完成请求/响应返回自定义的数据，返回Response/dio.resolve(data)

      //2. 终止一个请求/响应，返回DioError/dio.reject(errMsg) ，触发一个错误，上层catchError会被调用

      //3. 不仅支持同步任务，而且支持异步任务
      //    Response response = await dio.get("/token")
      //    option.header["token"] = response.data["data"]["token"];
      //    return options;

      //4. Lock/unlock，一旦请求/响应拦截器被锁定，接下来的请求/响应将会进入请求/响应拦截器之前排队等待。
      //    直到解锁后，这些入队的请求才会继续执行(进入拦截器)，这一些需要串行化请求/响应的场景非常实用
      //    tokenDio = new Dio();
      //    dio.interceptor.request.lock();
      //    Response response = await tokenDio.get("/token");
      //    options.headers["token"] = response.data["data"]["token"];
      //    dio.interceptor.request.unlock();
      //    return options;

      //5. 调用拦截器dio.interceptor.request.clear()清空等待队列

      //6.拦截器别名 dio.lock() = dio.interceptor.request.lock()
    };
    dio.interceptor.response.onSuccess = (Response response) {
      return response;
    };
    dio.interceptor.response.onError = (DioError e) {
      return e;
    };

    /// 转换器
    // 虽然拦截器中也可以对数据进行预处理，但是转换器的主要职责是对请求/响应数据进行编解码
    // 之所以将转换器单独分离，一是为了和拦截器解耦，二是为了不修改原始请求数据
    dio.transformer = DefaultTransformer();

    /// 代理
//    dio.onHttpClientCreate = (HttpClient client){
//      client.findProxy=(uri){
//        return "PROXY loaclhost:8888";
//      };
//    };

    /// CancelToken
    // 调用方法： cancelToken.cancel("cancelled");
    // 统一cancelToken可以用于多个请求，当一个cancelToken取消时，所有使用该cancelToken的请求都会被取消
    CancelToken cancelToken = new CancelToken();

    /// Cookie
    // 默认使用CookieJar自动管理cookie保存在内存中
    // 如果想对cookie进行持久化，使用PersistCookieJar，该实现了RFC中标准的cookie策略，将cookie保存在文件中，所以一直存在，除非显示调用delete删除
    PersistCookieJar persistCookieJar = new PersistCookieJar("./cookies");
    dio.cookieJar = persistCookieJar;
    try {
      Response response = await dio.request(url,
          data: params, cancelToken: cancelToken, options: options);

      Log.i(_tag, '''
      _request response
      data: ${response.data.toString()}
      headers: ${response.headers.toString()}
      options: ${response.request.toString()}
      statusCode: ${response.statusCode.toString()}
      extra: ${response.extra.toString()}
      ---
      ''');

      var statusCode = response.statusCode;
      if (statusCode < 0) {
        _handleError(errorCallback, "网络请求错误");
        return;
      }

      if (callback != null) {
        callback(response.data["data"]);
      }

    } on DioError catch (e) {
      _handleError(errorCallback, e);
    }
  }

  static _handleError(Function errorCallback, e) {
    String errorStr = e.toString();
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {}
    Log.i(_tag, "_handleError errorMsg: $errorStr");
    if (errorCallback != null) {
      errorCallback(errorStr);
    }
  }

  static _checkParamsNull(params) {
    return params != null && params.isNotEmpty;
  }
}

// https://www.jianshu.com/p/1352351c7d08
// https://github.com/flutterchina/dio/blob/flutter/example/interceptorLock.dart
//    Dio tokenDio = new Dio();
//    tokenDio.lock();
//    tokenDio
//        .get("/token")
//        .then((res) {})
//        .whenComplete(() => dio.unlock());
//
// contentType https://github.com/flutterchina/dio/blob/flutter/example/options.dart
