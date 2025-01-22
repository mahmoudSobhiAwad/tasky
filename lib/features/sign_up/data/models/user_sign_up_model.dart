class UserSignAuthModel {
  String id;
  String accessToken;
  String refreshToken;
  String userName;
  UserSignAuthModel(
      {required this.accessToken,
      required this.id,
      required this.refreshToken,
      required this.userName});
  factory UserSignAuthModel.fromJson(Map<String, dynamic> json) {
    return UserSignAuthModel(
        accessToken: json['access_token'],
        id: json['_id'],
        refreshToken: json['refresh_token'],
        userName: json['displayName'] ?? '');
  }
}
