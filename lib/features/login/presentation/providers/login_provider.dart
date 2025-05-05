import 'package:flutter/material.dart';
import 'package:flutter_course/features/login/presentation/domain/requests/login_request.dart';
import 'package:flutter_course/features/login/presentation/domain/services/login_service.dart';
import 'package:hive/hive.dart';

class LoginProvider with ChangeNotifier {
  bool isLoading = false;
  final AuthService _authService = AuthService();

  Future<bool> login(String username, String password) async {
    isLoading = true;
    notifyListeners();

    final loginRequest = LoginRequest(username: username, password: password);

    final userToken = await _authService.login(loginRequest);

    isLoading = false;
    notifyListeners();

    if (userToken != null) {
      final box = Hive.box('authBox');
      box.put('access_token', userToken.accessToken);
      box.put('refresh_token', userToken.refreshToken);
      box.put('token_type', userToken.tokenType);
      return true;
    }
    return false;
  }
}
