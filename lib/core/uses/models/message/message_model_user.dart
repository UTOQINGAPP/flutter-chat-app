class MessageModelUse {
  MessageModelUse({
    required this.from,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  String from;
  String to;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  factory MessageModelUse.fromJson(Map<String, dynamic> json) =>
      MessageModelUse(
        from: json["from"] ?? '',
        to: json["to"] ?? '',
        message: json["message"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
