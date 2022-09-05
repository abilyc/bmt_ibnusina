class User {
  final String userName;
  final String userId;
  final String userRole;
  final String token;

  User({required this.userName, required this.userId, required this.userRole, required this.token});

  User.fromJson(Map<String, dynamic> json)
      : userName = json['data']['login']['username'],
        userId = json['data']['login']['userId'],
        userRole = json['data']['login']['userRole'],
        token = json['data']['login']['token'];

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'userId': userId,
        'userRole': userRole,
        'token': token
      };
}
