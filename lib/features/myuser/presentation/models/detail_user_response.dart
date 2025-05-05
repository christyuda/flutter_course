class DetailUserResponse {
  final bool success;
  final String message;
  final DetailUserData data;

  DetailUserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DetailUserResponse.fromJson(Map<String, dynamic> json) {
    return DetailUserResponse(
      success: json['success'],
      message: json['message'],
      data: DetailUserData.fromJson(json['data']),
    );
  }
}

class DetailUserData {
  final String id;
  final String username;
  final String email;
  final String role;

  DetailUserData({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  factory DetailUserData.fromJson(Map<String, dynamic> json) {
    return DetailUserData(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
    );
  }
}
