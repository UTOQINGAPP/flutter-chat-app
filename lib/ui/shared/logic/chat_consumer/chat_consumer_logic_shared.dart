import 'package:chat/core/core.dart';
import 'package:chat/ui/shared/logic/dio/dio_logic_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_consumer_logic_shared.g.dart';

// Logic intermediary between the chat consumer and the UI that maintains a state,
// which obtains all messages from the database,
// between the authenticated user and the user selected for a chat.
@Riverpod(keepAlive: true)
class ChatConsumerLogicShared extends _$ChatConsumerLogicShared {
  late final ChatConsumerUse _consumer;

  @override
  List<MessageEntityRule> build() {
    final source = ChatSourceUse(ref.watch(dioSharedProvider));
    _consumer = ChatConsumerUse(source);

    return const <MessageEntityRule>[];
  }

  Future getMessages(String userUid) async {
    state = await _consumer.getChat(userUid);
  }
}
