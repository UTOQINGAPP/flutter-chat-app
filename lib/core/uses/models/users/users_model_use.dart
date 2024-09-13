// To parse this JSON data, do
//
//     final usersModelAuthenticationUse = usersModelAuthenticationUseFromJson(jsonString);
import 'package:chat/configs/configs.dart';
import 'package:chat/core/uses/models/user/user_model_use.dart';

UsersModelUse usersModelUseFromJson(String str) =>
    UsersModelUse.fromJson(json.decode(str));

String usersModelAuthenticationUseToJson(UsersModelUse data) =>
    json.encode(data.toJson());

class UsersModelUse {
  bool ok;
  List<UserModelUse> users;
  int from;

  UsersModelUse({
    required this.ok,
    required this.users,
    required this.from,
  });

  factory UsersModelUse.fromJson(Map<String, dynamic> json) => UsersModelUse(
        ok: json["ok"],
        users: List<UserModelUse>.from(
            json["users"].map((x) => UserModelUse.fromJson(x))),
        from: json["from"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "from": from,
      };
}
