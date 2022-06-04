import 'package:podfetch_api/models/user.dart';

class LoginResponse {
  final User? user;
  final String? token;
  final List<String>? errors;

  LoginResponse(this.user, this.token, this.errors);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      User.fromJson(json['user']),
      json['token'],
      (json['errors'] as List<dynamic>?)
          ?.map((e) => (e['message'] as String))
          .toList());
}
