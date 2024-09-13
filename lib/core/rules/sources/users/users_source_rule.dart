import 'package:chat/core/rules/entities/entities_rule.dart';

abstract class UsersSourceRule {
  Future<List<UserEntityRule>> getUsuarios();
}
