// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserModelUse userDataFromJson(String str) =>
    UserModelUse.fromJson(json.decode(str));

String userDataToJson(UserModelUse data) => json.encode(data.toJson());

class UserModelUse {
  String name;
  String email;
  bool online;
  String uid;

  UserModelUse({
    required this.name,
    required this.email,
    required this.online,
    required this.uid,
  });

  factory UserModelUse.fromJson(Map<String, dynamic> json) => UserModelUse(
        name: json["name"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "online": online,
        "uid": uid,
      };
}
