import 'dart:convert';
import 'package:chat/core/uses/models/user/user_model_use.dart';

LoginModelAuthenticationUse loginResponseFromJson(String str) =>
    LoginModelAuthenticationUse.fromJson(json.decode(str));

String loginResponseToJson(LoginModelAuthenticationUse data) =>
    json.encode(data.toJson());

class LoginModelAuthenticationUse {
  final bool ok;
  final UserModelUse user;
  final String token;

  LoginModelAuthenticationUse({
    required this.ok,
    required this.user,
    required this.token,
  });

  factory LoginModelAuthenticationUse.fromJson(Map<String, dynamic> json) =>
      LoginModelAuthenticationUse(
        ok: json["ok"],
        user: UserModelUse.fromJson(json["userDB"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "userDB": user.toJson(),
        "token": token,
      };
}
