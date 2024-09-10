import 'package:chat/core/core.dart';
import 'package:chat/ui/shared/logic/authentication_consumer/authentication_consumer_logic_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_logic_shared.g.dart';

@Riverpod(keepAlive: true)
class UserLogicShared extends _$UserLogicShared {
  @override
  UserEntityRule? build() {
    return ref.watch(authenticationConsumerLogicSharedProvider).user;
  }

  // Método para actualizar el usuario
  /* void updateUser({
    String? name,
    String? email,
    bool? online,
  }) {
    state = state?.copyWith(
      name: name,
      email: email,
      online: online,
    );
  } */
  update(UserEntityRule user) => state = user;
}
