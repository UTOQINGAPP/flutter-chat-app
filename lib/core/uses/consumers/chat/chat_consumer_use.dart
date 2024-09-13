import 'package:chat/core/rules/rules_core.dart';

class ChatConsumerUse implements ChatConsumerRule {
  final ChatSourceRule source;

  ChatConsumerUse(this.source);

  @override
  Future<List<MessageEntityRule>> getChat(String userUid) async {
    return await source.getChat(userUid);
  }
}
