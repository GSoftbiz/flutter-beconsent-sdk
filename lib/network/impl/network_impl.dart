
import 'package:flutter_beconsent_sdk/di/injector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_error.dart';
import 'package:flutter_beconsent_sdk/network/network.dart';
import 'package:flutter_beconsent_sdk/network/network_authentication.dart';

class NetworkImpl extends Network {
  final Dio _dio;
  final NetworkAuthentication? _authenticationDelegate;
  final Uuid uuid = const Uuid();
  final bool _enableLogging;

  NetworkImpl(
    this._dio, {
    NetworkAuthentication? authenticationDelegate,
    bool enableLogging = true,
    List<Interceptor> interceptors = const [],
  })  : _authenticationDelegate = authenticationDelegate,
        _enableLogging = enableLogging {
    _initInterceptors(interceptors);
  }

  _initInterceptors(List<Interceptor> interceptors) {
    _dio.interceptors.add(_interceptorsRequestWrapper());
    _dio.interceptors.add(_interceptorsErrorWrapper());
    for (var interceptor in interceptors) {
      _dio.interceptors.add(interceptor);
    }
    if (kDebugMode && _enableLogging) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  InterceptorsWrapper _interceptorsRequestWrapper() => InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Content-Type"] = "application/json";
          options.headers["Accept"] = "application/json";
          options.headers['Accept-Language'] = "en";

          String? validateToken = _authenticationDelegate?.validateToken;
          if(validateToken!=null){
            options.headers['Validate-Token'] = validateToken;
          }
          var token = _authenticationDelegate?.accessToken;
          if (token != null && token.isNotEmpty && options.path != "/guest/auth/refresh_token") {
              //debugPrint("token : "+token);
              options.headers['Authorization'] = "Bearer $token";
          }

          return handler.next(options);
        },
      );

  InterceptorsWrapper _interceptorsErrorWrapper() => InterceptorsWrapper(
        onError: (e, handler) async {
          var response = e.response ?? e;
          if (response is Response) {
            debugPrint("response.requestOptions.path. = "+response.requestOptions.path);
            if (response.statusCode == 401 &&
                _authenticationDelegate?.accessToken != null && response.requestOptions.path!="/guest/auth/refresh_token") {
              final refreshSucceed =
                  await _authenticationDelegate?.doRefreshToken();
              if (refreshSucceed ?? false) {
                return handler.resolve(await _retry(response.requestOptions));
              }
            }
          }
          return handler.next(e);
        },
      );

  String _url(String path) {
    return _dio.options.baseUrl + path;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    var resendResponse = await _createOperation(
      requestOptions.path,
      method: requestOptions.method,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      headers: requestOptions.headers,
    );
    return resendResponse;
  }

  String getRequestId(headers) {
    String requestId = uuid.v4();
    if (headers != null) {
      if (headers['X-Request-ID'] == null) {
        headers['X-Request-ID'] = requestId;
      } else {
        requestId = headers['X-Request-ID'];
      }
    } else {
      headers = {'X-Request-ID': requestId};
    }
    return requestId;
  }

  Future<Response> _createOperation(
    String path, {
    required String method,
    data,
    headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response result = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            method: method,
            headers: headers,
            ),
      );
      return result;

    } on DioError catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        final message = data is String ? data : data["message"] ?? "";
        final ee = NetworkError(
          _url(path),
          message: message.toString(),
          statusCode: e.response?.statusCode ?? 400,
          internalStatusCode: data is String ? data : data["code"]!=null?data["code"]:"",
        );
        throw ee;
      } else {
        throw NetworkError(
          _url(path),
          message: "Something went wrong",
          statusCode: e.response?.statusCode ?? 500,
          internalStatusCode: "Something went wrong",
        );
      }
    }
  }

  @override
  Future<Response> get(
    String path, {
    dynamic headers,
    dynamic query,
  }) async {
    return await _createOperation(
      path,
      method: "GET",
      headers: headers,
      queryParameters: query,
    );
  }

  @override
  Future<Response> post(
    String path, {
    dynamic headers,
    dynamic body,
  }) async {
    return await _createOperation(
      path,
      method: "POST",
      headers: headers,
      data: body,
    );
  }

  @override
  Future<Response> put(
    String path, {
    dynamic headers,
    dynamic body,
  }) async {
    return await _createOperation(
      path,
      method: "PUT",
      headers: headers,
      data: body,
    );
  }

  @override
  Future<Response> patch(
    String path, {
    dynamic headers,
    dynamic body,
  }) async {
    return await _createOperation(
      path,
      method: "PATCH",
      headers: headers,
      data: body,
    );
  }

  @override
  Future<Response> delete(
    String path, {
    dynamic headers,
    dynamic body,
  }) async {
    return await _createOperation(
      path,
      method: "DELETE",
      headers: headers,
      data: body,
    );
  }

  @override
  Future<Response> upload(
    String path, {
    required FormData formData,
    dynamic headers,
  }) async {
    return await _createOperation(
      path,
      method: "POST",
      headers: headers,
      data: formData,
    );
  }
}
