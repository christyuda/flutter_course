class RegisterResponse {
  final bool success;
  final String message;
  final RegisterData? data;

  RegisterResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
    );
  }
}

class RegisterData {
  final String userId;
  final String username;
  final String email;
  final String role;
  final String createdAt;

  RegisterData({
    required this.userId,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      createdAt: json['createdAt'],
    );
  }
}
