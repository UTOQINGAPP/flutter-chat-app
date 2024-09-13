import 'package:chat/core/rules/rules_core.dart';
import 'package:chat/core/uses/models/models_use.dart';

class MessageAdapterUse {
  static MessageEntityRule toEntity(MessageModelUse messageData) {
    return MessageEntityRule(
      fromUid: messageData.from,
      toUid: messageData.to,
      message: messageData.message,
    );
  }
}
