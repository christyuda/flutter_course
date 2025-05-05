import 'dart:convert';
import 'package:flutter_course/core/utils/networking_helper.dart';
import '../../domain/models/user_token.dart';
import '../../domain/requests/login_request.dart';

class AuthService {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<UserToken?> login(LoginRequest request) async {
    final response = await _networkHelper.post(
      "/api/auth/login",
      request.toJson(),  // ✅ gunakan model request.toJson()
    );

    if (response != null && response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        return UserToken.fromJson(jsonResponse['data']);
      }
    }
    return null;
  }
}
