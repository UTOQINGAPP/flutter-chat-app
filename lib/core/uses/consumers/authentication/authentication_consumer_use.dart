import 'package:chat/core/rules/rules_core.dart';

class AuthenticationConsumerUse implements AuthenticationConsumerRule {
  final AuthenticationSourceRule source;

  AuthenticationConsumerUse(this.source);

  @override
  Future<(bool, UserEntityRule)> login(String email, String password) async {
    final loginModelAuthenticationSource = await source.login(email, password);

    return loginModelAuthenticationSource;
  }

  @override
  Future<(bool, UserEntityRule)> register(
      String fullName, String email, String password) async {
    final loginModelAuthenticationSource =
        await source.register(fullName, email, password);

    return loginModelAuthenticationSource;
  }

  @override
  Future<(bool, UserEntityRule?)> isLoggedIn() async {
    final isLoggedInSource = await source.isLoggedIn();
    return isLoggedInSource;
  }

  @override
  Future<bool> logout() async {
    final islogoutInSource = await source.logout();
    return islogoutInSource;
  }
}
