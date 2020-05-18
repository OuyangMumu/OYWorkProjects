/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/5
 */

import 'package:dio/dio.dart';

class HttpError {
  static const int code_Unauthorized = 401;
  static const int code_Forbidden = 403;
  static const int code_Notfound = 404;
  static const int code_Request_TimeOut = 408;
  static const int code_InternalServerError = 500;
  static const int code_BadGateway = 502;
  static const int code_ServiceUnavailable = 503;
  static const int code_GatewayTimeOut = 401;

  ///未知错误
  static const String error_Unknow = 'UNKNOW';

  ///解析错误
  static const String error_Parse = 'PARSE_ERROR';

  ///网络错误
  static const String error_Network = 'NETWORK_ERROR';

  ///协议错误
  static const String error_Http = 'HTTP_ERROR';

  ///证书错误
  static const String error_SSL = 'SSL_ERROR';

  ///连接超时
  static const String error_ConnectTimeOut = 'CONNECT_TIMEOUT';

  ///响应超时
  static const String error_ReceiveTimeOut = 'RECEIVE_TIMEOUT';

  ///发送超时
  static const String error_SendTimeOut = 'SEND_TIMEOUT';

  ///网络请求取消
  static const String error_Cancel = 'CANCEL';

  String code;
  String message;
  HttpError(this.code, this.message);
  HttpError.dioError(DioError error) {
    message = error.message;
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        code = error_ConnectTimeOut;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        code = error_ReceiveTimeOut;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.SEND_TIMEOUT:
        code = error_SendTimeOut;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.RESPONSE:
        code = error_Http;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.CANCEL:
        code = error_Cancel;
        message = "请求已被取消，请重新请求";
        break;
      case DioErrorType.DEFAULT:
        code = error_Unknow;
        message = "网络异常，请稍后重试！";
        break;
    }
  }

  @override
  String toString() {
    return 'HttpError{code: $code, message: $message}';
  }
}
