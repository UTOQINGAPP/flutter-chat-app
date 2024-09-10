import 'package:chat/core/rules/rules_core.dart';
import 'package:chat/core/uses/models/models_use.dart';

class UserAdapterUse {
  static UserEntityRule toEntity(UserModelUse userData) {
    return UserEntityRule(
      name: userData.name,
      email: userData.email,
      online: userData.online,
      uid: userData.uid,
    );
  }
}
