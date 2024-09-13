import 'package:chat/core/core.dart';
import 'package:chat/ui/shared/logic/dio/dio_logic_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_consumer_logic_shared.g.dart';

// Logic intermediary between the users consumer and the UI that maintains a state,
// which gets all users from the database except the user who requested them.
@Riverpod(keepAlive: true)
class UsersConsumerShared extends _$UsersConsumerShared {
  late final UsersConsumerUse _consumer;

  @override
  Future<List<UserEntityRule>> build() async {
    final source = UsersSourceUse(ref.watch(dioSharedProvider));
    _consumer = UsersConsumerUse(source);
    return _consumer.getUsuarios();
  }

  refresh() async {
    state = AsyncValue.data(await _consumer.getUsuarios());
  }
}
