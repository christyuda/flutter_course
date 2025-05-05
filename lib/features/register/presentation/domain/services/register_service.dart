import 'dart:convert';
import 'package:flutter_course/core/utils/networking_helper.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';

class RegisterService {
  final NetworkHelper _networkHelper = NetworkHelper();
  String? message;
  Future<bool> register(RegisterRequest request) async {
  try {
    final response = await _networkHelper.post('/api/auth/register', request.toJson());

    if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
      final json = jsonDecode(response.body);
      if (json['success'] == true) {
        return true;
      } else {
        message = json['error']?['message'] ?? 'Registrasi gagal';
        return false;
      }
    } else {
      message = 'Error server (${response?.statusCode})';
      return false;
    }
  } catch (e) {
    message = 'Terjadi kesalahan: $e';
    return false;
  }
}

}
