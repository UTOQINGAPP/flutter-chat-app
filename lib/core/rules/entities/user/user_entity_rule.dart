class UserEntityRule {
  String name;
  String email;
  bool online;
  String uid;

  UserEntityRule({
    required this.name,
    required this.email,
    required this.online,
    required this.uid,
  });

  UserEntityRule copyWith({
    String? name,
    String? email,
    bool? online,
  }) {
    return UserEntityRule(
      name: name ?? this.name,
      email: email ?? this.email,
      online: online ?? this.online,
      uid: uid,
    );
  }
}
