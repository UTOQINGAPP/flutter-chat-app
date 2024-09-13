import 'package:chat/core/rules/entities/entities_rule.dart';

abstract class ChatSourceRule {
  Future<List<MessageEntityRule>> getChat(String userUid);
}
