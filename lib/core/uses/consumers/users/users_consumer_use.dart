import 'package:chat/core/rules/rules_core.dart';

class UsersConsumerUse implements UsersConsumerRule {
  final UsersSourceRule source;

  UsersConsumerUse(this.source);

  @override
  Future<List<UserEntityRule>> getUsuarios() async {
    return await source.getUsuarios();
  }
}
