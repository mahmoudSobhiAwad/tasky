class UserSignUpModel {
  String id;
  String accessToken;
  String refreshToken;
  String userName;
  UserSignUpModel(
      {required this.accessToken,
      required this.id,
      required this.refreshToken,
      required this.userName});
  factory UserSignUpModel.fromJson(Map<String, dynamic> json) {
    return UserSignUpModel(
        accessToken: json['access_token'],
        id: json['_id'],
        refreshToken: json['refresh_token'],
        userName: json['displayName']);
  }
}


