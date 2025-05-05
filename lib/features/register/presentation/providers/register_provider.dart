import 'package:flutter/material.dart';
import 'package:flutter_course/features/register/presentation/domain/models/register_request.dart';
import 'package:flutter_course/features/register/presentation/domain/services/register_service.dart';


class RegisterProvider with ChangeNotifier {
  final RegisterService _registerService = RegisterService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _message;
  String? get message => _message;

  Future<bool> register(RegisterRequest request) async {
    _isLoading = true;
    notifyListeners();

   final response = await _registerService.register(request);

_isLoading = false;
notifyListeners();

if (response == true) {
  _message = "Registration successful";
  return true;
} else {
  _message = "Registration failed";
  return false;
}

  }
}
