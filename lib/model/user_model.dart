class UserModel {
  String userName;
  String userEmail;

  UserModel({this.userName, this.userEmail});

  UserModel.fromMap(Map<String, dynamic> map)
      : userName = map["userName"],
        userEmail = map["userEmail"];

  Map<String, dynamic> toMap() {
    return {
      "userName": userName,
      "userEmail": userEmail,
    };
  }
}
