import 'dart:convert';
import 'dart:developer' as logprint;
import 'package:flutter_course/core/config/env.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkHelper {
  final String? token;

  NetworkHelper({ this.token});
String get baseUrl => Env.baseUrl;
  /// ======================
  /// Standard JSON headers
  /// ======================
  Map<String, String> _headers({Map<String, String>? extraHeaders}) {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
      ...?extraHeaders,
    };
  }

  /// ======================
  /// GET Request
  /// ======================
  Future<http.Response?> get(String endpoint,
      {Map<String, String>? headers}) async {
    bool connected = await InternetConnectionChecker.createInstance().hasConnection;
    if (!connected) {
      logprint.log("No internet connection", name: "NetworkHelper");
      return null;
    }

    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.get(url, headers: _headers(extraHeaders: headers));
      _logResponse(response);
      return response;
    } catch (e) {
      logprint.log(e.toString(), name: "NetworkHelper");
      return null;
    }
  }

  /// ======================
  /// POST Request
  /// ======================
  Future<http.Response?> post(String endpoint, dynamic body,
      {Map<String, String>? headers}) async {
    bool connected = await InternetConnectionChecker.createInstance().hasConnection;
    if (!connected) {
      logprint.log("No internet connection", name: "NetworkHelper");
      return null;
    }

    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.post(url,
          headers: _headers(extraHeaders: headers),
          body: jsonEncode(body));
      _logResponse(response);
      return response;
    } catch (e) {
      logprint.log(e.toString(), name: "NetworkHelper");
      return null;
    }
  }

  /// ======================
  /// PUT Request
  /// ======================
  Future<http.Response?> put(String endpoint, dynamic body,
      {Map<String, String>? headers}) async {
    bool connected = await InternetConnectionChecker.createInstance().hasConnection;
    if (!connected) {
      logprint.log("No internet connection", name: "NetworkHelper");
      return null;
    }

    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.put(url,
          headers: _headers(extraHeaders: headers),
          body: jsonEncode(body));
      _logResponse(response);
      return response;
    } catch (e) {
      logprint.log(e.toString(), name: "NetworkHelper");
      return null;
    }
  }

  /// ======================
  /// DELETE Request
  /// ======================
  Future<http.Response?> delete(String endpoint,
      {Map<String, String>? headers}) async {
    bool connected = await InternetConnectionChecker.createInstance().hasConnection;
    if (!connected) {
      logprint.log("No internet connection", name: "NetworkHelper");
      return null;
    }

    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response =
          await http.delete(url, headers: _headers(extraHeaders: headers));
      _logResponse(response);
      return response;
    } catch (e) {
      logprint.log(e.toString(), name: "NetworkHelper");
      return null;
    }
  }

  /// ======================
  /// Multipart POST
  /// ======================
  Future<http.StreamedResponse?> postMultipart(
      String endpoint, Map<String, String> fields,
      {Map<String, String>? headers, List<http.MultipartFile>? files}) async {
    bool connected = await InternetConnectionChecker.createInstance().hasConnection;
    if (!connected) {
      logprint.log("No internet connection", name: "NetworkHelper");
      return null;
    }

    final url = Uri.parse("$baseUrl$endpoint");
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(_headers(extraHeaders: headers));
    request.fields.addAll(fields);

    if (files != null) {
      request.files.addAll(files);
    }

    try {
      final response = await request.send();
      logprint.log("Multipart sent: $endpoint", name: "NetworkHelper");
      return response;
    } catch (e) {
      logprint.log(e.toString(), name: "NetworkHelper");
      return null;
    }
  }

  /// ======================
  /// Logging Helper
  /// ======================
  void _logResponse(http.Response response) {
    logprint.log("STATUS: ${response.statusCode}", name: "NetworkHelper");
    logprint.log("BODY: ${response.body}", name: "NetworkHelper");
  }
}
