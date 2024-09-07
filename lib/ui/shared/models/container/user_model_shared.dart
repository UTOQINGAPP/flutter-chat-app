class UserModelShared {
  final bool online;
  final String email;
  final String name;
  final String uid;

  UserModelShared({
    required this.online,
    required this.email,
    required this.name,
    required this.uid,
  });

  UserModelShared copyWith({
    bool? online,
    String? email,
    String? name,
  }) {
    return UserModelShared(
      online: online ?? this.online,
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid,
    );
  }
}
