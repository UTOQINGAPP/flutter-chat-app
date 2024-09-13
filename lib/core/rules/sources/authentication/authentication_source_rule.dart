import 'package:chat/core/rules/entities/entities_rule.dart';

abstract class AuthenticationSourceRule {
  Future<(bool, UserEntityRule)> login(String email, String password);
  Future<(bool, UserEntityRule)> register(
      String fullName, String email, String password);
  Future<(bool, UserEntityRule?)> isLoggedIn();
  Future<bool> logout();
}
