import 'package:chat/core/rules/rules_core.dart';
import 'package:chat/core/uses/models/models_use.dart';

class AuthenticationConsumerUse implements AuthenticationConsumerRule {
  final AuthenticationSourceRule source;

  AuthenticationConsumerUse(this.source);

  @override
  Future<LoginModelAuthenticationUse> login(
      String email, String password) async {
    final loginModelAuthenticationSource = await source.login(email, password);

    return loginModelAuthenticationSource;
  }

  @override
  Future<LoginModelAuthenticationUse> register(
      String fullName, String email, String password) async {
    final loginModelAuthenticationSource =
        await source.register(fullName, email, password);

    return loginModelAuthenticationSource;
  }

  @override
  Future<LoginModelAuthenticationUse?> isLoggedIn() async {
    final isLoggedInSource = await source.isLoggedIn();
    return isLoggedInSource;
  }

  @override
  late UserEntityRule? user = source.user;

  @override
  Future<bool> logout() async {
    final islogoutInSource = await source.logout();
    return islogoutInSource;
  }
}
