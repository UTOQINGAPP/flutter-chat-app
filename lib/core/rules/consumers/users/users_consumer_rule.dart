import 'package:chat/core/rules/entities/entities_rule.dart';

abstract class UsersConsumerRule {
  Future<List<UserEntityRule>> getUsuarios();
}
