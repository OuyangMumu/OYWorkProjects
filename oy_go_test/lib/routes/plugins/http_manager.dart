import 'dart:core';

import 'package:connectivity/connectivity.dart';
/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/5
 */

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:oy_go_test/log_util.dart';
import 'package:oy_go_test/routes/plugins/http_address.dart';
import 'package:oy_go_test/routes/plugins/http_error.dart';
import 'package:oy_go_test/routes/plugins/http_logs_interceptor.dart';
import 'package:oy_go_test/routes/plugins/http_response_interceptor.dart';

///http请求成功回调
typedef HttpSuccessCallback<T> = void Function(dynamic data);

///失败回调
typedef HttpFailureCallback = void Function(HttpError data);

///数据解析回调
typedef T JsonParse<T>(dynamic data);

/// 1>：首先从本地数据库的缓存中读取数据，如果缓存有数据，就直接显示列表数据，同时去请求服务器，如果服务器返回数据了，这个时候就去比对服务器返回的数据与缓存中的数据，看是否一样；
/// 2>：如果比对结果是一样，那么直接return返回，不做任何操作；
/// 3>：如果比对结果不一样，就去刷新列表数据，同时把之前数据库中的数据删除，然后存储新的数据；
class HttpManager {
  // 同一个CancelToken可以用于多个请求，当一个CancelToken取消时，
  // 所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  Map<String, CancelToken> _cancelTokens = Map<String, CancelToken>();

  static const int connectTimeOut = 3000;
  static const int receiveTimeOut = 3000;

  static const String GET = 'get';
  static const String POST = 'post';

  Dio _dio;
  static final HttpManager _instance = HttpManager._internal();
  factory HttpManager() => _instance;
  HttpManager._internal() {
    if (_dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = BaseOptions(
        baseUrl: Address.BASE_URL,
        connectTimeout: connectTimeOut,
        receiveTimeout: receiveTimeOut,
      );
      _dio = Dio(options);
      _dio.interceptors.add(new LogsInterceptors());
      _dio.interceptors.add(new ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Address.BASE_URL) {
        _dio.options.baseUrl = Address.BASE_URL;
      }
    }
    return this;
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器

  void init(
      {String baseUrl,
      int connectTimeOut,
      int receiveTimeOut,
      List<Interceptor> interceptors}) {
    _dio.options = _dio.options.merge(
        baseUrl: baseUrl,
        connectTimeout: connectTimeOut,
        receiveTimeout: receiveTimeOut);
    if (interceptors != null && interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  ///Get网络请求
  ///[url] 网络请求地址不包含域名
  ///[tag] 请求统一标识，用于取消网络请求
  void get({
    @required String url,
    @required String tag,
    Map<String, dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
  }) async {
    _request(
      url: url,
      tag: tag,
      params: params,
      method: GET,
      successCallback: successCallback,
      failureCallback: failureCallback,
    );
  }

  ///post网络请求
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[tag] 请求统一标识，用于取消网络请求

  void post({
    @required String url,
    @required String tag,
    Map<String, dynamic> params,
    data,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
  }) async {
    _request(
      url: url,
      tag: tag,
      data: data,
      method: POST,
      params: params,
      successCallback: successCallback,
      failureCallback: failureCallback,
    );
  }

  ///统一网络请求入口
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[data] post 请求参数
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求

  void _request({
    @required String url,
    @required String tag,
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
  }) async {
    bool available =
        await _connectivityAvailable(failureCallback: failureCallback);
    if (!available) return;

    params = params ?? {};
    method = method ?? 'GET';
    url = _resetFullUrl(url, params);

    options?.method = method;
    options = options ?? Options(method: method);

    try {
      ///1. 网络取消事务
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }

      ///2.
      Response<Map<String, dynamic>> response = await _dio.request(
        url,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );
      String statusCode = response.data['statusCode'];
      if (statusCode == '0') {
        if (successCallback != null) {
          successCallback(response.data['data']);
        }
      } else {
        String message = response.data['statusDesc'];
        LogUtil.v('请求服务器出错：$message');
        if (failureCallback != null) {
          failureCallback(HttpError(statusCode, message));
        }
      }
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      if (failureCallback != null && e.type != DioErrorType.CANCEL) {
        failureCallback(HttpError.dioError(e));
      }
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      if (failureCallback != null) {
        failureCallback(HttpError(HttpError.error_Unknow, "网络异常，请稍后重试！"));
      }
    }
  }

  ///下载文件
  ///[url] 下载地址
  ///[savePath]  文件保存路径
  ///[onReceiveProgress]  下载进度
  ///[params] url请求参数支持restful
  ///[data] post 请求参数
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void download({
    @required String url,
    @required savePath,
    @required String tag,
    ProgressCallback progressCallback,
    Map<String, dynamic> params,
    data,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
  }) async {
    bool available =
        await _connectivityAvailable(failureCallback: failureCallback);
    if (!available) return;

    params = params ?? {};
    url = _resetFullUrl(url, params);

    /// 0代表不设置超时
    int receiveTimeout = 0;
    options ??= options == null
        ? Options(receiveTimeout: receiveTimeout)
        : options.merge(receiveTimeout: receiveTimeout);

    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }

      Response response = await _dio.download(
        url,
        savePath,
        onReceiveProgress: progressCallback,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      if (successCallback != null) {
        successCallback(response.data);
      }
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      if (failureCallback != null && e.type != DioErrorType.CANCEL) {
        failureCallback(HttpError.dioError(e));
      }
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      if (failureCallback != null) {
        failureCallback(HttpError(HttpError.error_Unknow, "网络异常，请稍后重试！"));
      }
    }
  }

  ///上传文件
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[onSendProgress] 上传进度
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  ///
  void upload({
    @required String url,
    @required String tag,
    FormData data,
    ProgressCallback progressCallback,
    Map<String, dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
  }) async {
    bool available =
        await _connectivityAvailable(failureCallback: failureCallback);
    if (!available) return;

    params = params ?? {};
    url = _resetFullUrl(url, params);

    options?.method = POST;
    options = options ?? Options(method: POST);

    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }

      Response<Map<String, dynamic>> response = await _dio.request(
        url,
        onSendProgress: progressCallback,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );

      String statusCode = response.data["statusCode"];
      if (statusCode == '0') {
        if (successCallback != null) {
          successCallback(response.data['data']);
        }
      } else {
        //失败
        String message = response.data["statusDesc"];
        LogUtil.v("请求服务器出错：$message");
        if (failureCallback != null) {
          failureCallback(HttpError(statusCode, message));
        }
      }
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      if (failureCallback != null && e.type != DioErrorType.CANCEL) {
        failureCallback(HttpError.dioError(e));
      }
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      if (failureCallback != null) {
        failureCallback(HttpError(HttpError.error_Unknow, "网络异常，请稍后重试！"));
      }
    }
  }

  ///取消网络请求
  void cancel(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag].isCancelled) {
        _cancelTokens[tag].cancel();
      }
      _cancelTokens.remove(tag);
    }
  }

  Future<bool> _connectivityAvailable(
      {HttpFailureCallback failureCallback}) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (failureCallback != null) {
        failureCallback(HttpError(HttpError.error_Network, "网络异常，请稍后重试！"));
      }
      LogUtil.v("请求网络异常，请稍后重试！");
      return false;
    }
    return true;
  }

  String _resetFullUrl(String url, Map<String, dynamic> params) {
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return url;
  }
}
