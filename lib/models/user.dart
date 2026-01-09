class UserModel {
  final String email;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      email: json['email'] ?? '',
       accessToken: json['access_token'] ,
        refreshToken: json['refresh_token']);
  }
}