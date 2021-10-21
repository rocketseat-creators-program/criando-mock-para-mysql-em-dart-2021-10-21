import 'dart:convert';


class SignInRequest {
  
  String email;
  String password;

  SignInRequest({
    required this.email,
    required this.password,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory SignInRequest.fromMap(Map<String, dynamic> map) {
    return SignInRequest(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInRequest.fromJson(String source) => SignInRequest.fromMap(json.decode(source));
}
