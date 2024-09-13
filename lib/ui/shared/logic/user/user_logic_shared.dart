import 'package:chat/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_logic_shared.g.dart';

// Logic that maintains the state of the authenticated user.
@Riverpod(keepAlive: true)
class UserLogicShared extends _$UserLogicShared {
  @override
  UserEntityRule build() {
    return UserEntityRule(
        name: 'Name', email: 'Email', online: false, uid: '000');
  }

  update(UserEntityRule user) => state = user;
}
