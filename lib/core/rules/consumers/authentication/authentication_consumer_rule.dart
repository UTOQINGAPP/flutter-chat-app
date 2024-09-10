import 'package:chat/core/rules/entities/entities_rule.dart';
import 'package:chat/core/uses/uses_core.dart';

abstract class AuthenticationConsumerRule {
  late UserEntityRule? user;

  Future<LoginModelAuthenticationUse> login(String email, String password);
  Future<LoginModelAuthenticationUse> register(
      String fullName, String email, String password);
  Future<LoginModelAuthenticationUse?> isLoggedIn();
  Future<bool> logout();
}
