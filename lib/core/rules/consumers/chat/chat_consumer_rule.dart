import 'package:chat/core/rules/entities/entities_rule.dart';

abstract class ChatConsumerRule {
  Future<List<MessageEntityRule>> getChat(String userUid);
}
