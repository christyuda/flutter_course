import 'package:flutter/foundation.dart';
import 'package:flutter_course/features/myuser/presentation/models/detail_user_response.dart';
import 'package:flutter_course/features/myuser/presentation/services/user_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  DetailUserData? _userData;
  DetailUserData? get userData => _userData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserProvider() {
    fetchUserProfile(); // ✅ langsung dipanggil begitu Provider dibuat
  }

  Future<void> fetchUserProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _userService.fetchUserProfile();
      if (response != null && response.success) {
        _userData = response.data;
      } else {
        print("Gagal fetch user profile / response null");
      }
    } catch (e) {
      print("Error fetchUserProfile di provider: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void logout() async {
    final box = await Hive.openBox('authBox');
    await box.clear();
    _userData = null;
    notifyListeners();
  }
}
