import 'dart:convert';
import 'package:flutter_course/core/utils/networking_helper.dart';
import 'package:flutter_course/features/myuser/presentation/models/detail_user_response.dart';
import 'package:hive/hive.dart';

class UserService {

  UserService();

  Future<DetailUserResponse?> fetchUserProfile() async {
    try {
      // Ambil token dari Hive
      final box = await Hive.openBox('authBox');
      final storedToken = box.get('access_token');

      if (storedToken == null) {
        print("Token not found in Hive");
        return null;
      }

      // Buat NetworkHelper dengan token
      final authorizedHelper = NetworkHelper(token: storedToken);

      // Panggil endpoint
      final response = await authorizedHelper.get('/api/auth/me');

      if (response != null && response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          return DetailUserResponse.fromJson(jsonResponse);
        }
      }

      return null;
    } catch (e) {
      print("Error fetch user: $e");
      return null;
    }
  }
}
