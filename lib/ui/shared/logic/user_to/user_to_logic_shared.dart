import 'package:chat/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_to_logic_shared.g.dart';

// Logic that maintains the state of the user selected for a chat.
@Riverpod(keepAlive: true)
class UserToLogicShared extends _$UserToLogicShared {
  @override
  UserEntityRule build() {
    return UserEntityRule(
        name: 'Name', email: 'Email', online: false, uid: '000');
  }

  update(UserEntityRule user) => state = user;
}
