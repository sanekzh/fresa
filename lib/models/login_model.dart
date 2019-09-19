class LoginModel {
  final String userName;
  final String token;
  final String firebase_token;
  final int userId;

  LoginModel(this.userName, this.token, this.firebase_token, this.userId);

  LoginModel.fromJson(Map<String, dynamic> json)
      : userName = json['name'],
        token = json['token'],
        firebase_token = json['firebase_token'],
        userId = json['id'];

  Map<String, dynamic> toJson() =>
      {
        'username': userName,
        'token': token,
        'firebase_token': firebase_token,
        'id': userId,
      };
}