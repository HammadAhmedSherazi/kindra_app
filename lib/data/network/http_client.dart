import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_exceptions.dart';
import '../../services/base_api_services.dart';

class MyHttpClient extends BaseApiServices {
  MyHttpClient._();
  static final MyHttpClient _instance = MyHttpClient._();
  static MyHttpClient get instance => _instance;

  String queryParameters(Map<String, dynamic> params) {
    final query = <String>[];
    params.forEach((key, value) {
      if (value == null) return;
      if (value is List) {
        for (var v in value) {
          query.add(
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(v.toString())}');
        }
      } else {
        query.add(
            '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value.toString())}');
      }
    });
    return query.isEmpty ? '' : '?${query.join('&')}';
  }

  Future<Map<String, String>> _headers(
      Map<String, String>? custom, bool isToken) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (isToken) {
      // Add token from secure storage when implemented
      // final token = await SecureStorageManager.sharedInstance.getToken();
      // if (token != null) headers['Authorization'] = 'Bearer $token';
    }
    if (custom != null) headers.addAll(custom);
    return headers;
  }

  dynamic _returnResponse(http.Response response) {
    if (kDebugMode) {
      print("Response [${response.statusCode}]: ${response.body}");
    }
    final body = response.body.isEmpty ? null : response.body;
    switch (response.statusCode) {
      case 200:
      case 201:
      case 203:
      case 204:
        return body != null ? jsonDecode(utf8.decode(response.bodyBytes)) : null;
      case 400:
        throw BadRequestException(
            response.statusCode, body ?? 'Bad request');
      case 401:
        throw UnauthorisedException(
            response.statusCode, body ?? 'Unauthorized');
      case 404:
        throw NotFoundRequestException(
            response.statusCode, body ?? 'Not found');
      case 408:
        throw RequestTimeOutException(
            response.statusCode, body ?? 'Request timeout');
      case 500:
        throw ServerException(response.statusCode, 'Server error');
      default:
        throw FetchDataException(
            response.statusCode, body ?? 'Something went wrong');
    }
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
  }) async {
    final base = isBaseUrl ? BaseApiServices.baseURL : '';
    final uri = base + url + (params != null ? queryParameters(params) : '');
    final parsed = Uri.parse(uri);
    try {
      final response = await http
          .get(parsed, headers: await _headers(headers, isToken))
          .timeout(const Duration(seconds: 30));
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException(800, 'No internet connection');
    }
  }

  @override
  Future<dynamic> post(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
  }) async {
    final base = isBaseUrl ? BaseApiServices.baseURL : '';
    final uri = base + url + (params != null ? queryParameters(params) : '');
    final parsed = Uri.parse(uri);
    try {
      final response = await http
          .post(
            parsed,
            body: isJsonEncode && body != null ? jsonEncode(body) : body,
            headers: await _headers(headers, isToken),
          )
          .timeout(const Duration(seconds: 30));
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException(800, 'No internet connection');
    }
  }

  @override
  Future<dynamic> put(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
  }) async {
    final base = isBaseUrl ? BaseApiServices.baseURL : '';
    final uri = base + url + (params != null ? queryParameters(params) : '');
    final parsed = Uri.parse(uri);
    try {
      final response = await http
          .put(
            parsed,
            body: isJsonEncode && body != null ? jsonEncode(body) : body,
            headers: await _headers(headers, isToken),
          )
          .timeout(const Duration(seconds: 30));
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException(800, 'No internet connection');
    }
  }

  @override
  Future<dynamic> delete(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool isToken = true,
    bool isBaseUrl = true,
    bool isJsonEncode = true,
  }) async {
    final base = isBaseUrl ? BaseApiServices.baseURL : '';
    final uri = base + url + (params != null ? queryParameters(params) : '');
    final parsed = Uri.parse(uri);
    try {
      final response = await http
          .delete(
            parsed,
            body: isJsonEncode && body != null ? jsonEncode(body) : body,
            headers: await _headers(headers, isToken),
          )
          .timeout(const Duration(seconds: 30));
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException(800, 'No internet connection');
    }
  }
}
