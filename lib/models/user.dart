class User {
  String? userName;
  String? userId;
  String? userRole;
  String? token;

  User({this.userName = '', this.userId = '', this.userRole = '', this.token = ''});

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
