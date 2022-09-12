import 'package:dio/dio.dart';

abstract class Network {
  Future<Response> get(
    String path, {
    dynamic headers,
    dynamic query,
  });

  Future<Response> post(
    String path, {
    dynamic headers,
    dynamic body,
  });

  Future<Response> put(
    String path, {
    dynamic headers,
    dynamic body,
  });

  Future<Response> patch(
    String path, {
    dynamic headers,
    dynamic body,
  });

  Future<Response> delete(
    String path, {
    dynamic headers,
    dynamic body,
  });

  Future<Response> upload(
    String path, {
    required FormData formData,
    dynamic headers,
  });
}
