import 'dart:convert';

import 'package:chat/core/uses/models/message/message_model_user.dart';

ChatModelUse chatModelUserFromJson(String str) =>
    ChatModelUse.fromJson(json.decode(str));

String chatModelUserToJson(ChatModelUse data) => json.encode(data.toJson());

class ChatModelUse {
  ChatModelUse({
    required this.ok,
    required this.messages,
  });

  bool ok;
  List<MessageModelUse> messages;

  factory ChatModelUse.fromJson(Map<String, dynamic> json) => ChatModelUse(
        ok: json["ok"] ?? false,
        messages: List<MessageModelUse>.from(
            json["messages"]?.map((x) => MessageModelUse.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}
