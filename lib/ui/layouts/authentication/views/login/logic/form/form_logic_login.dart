import 'package:chat/configs/configs.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_logic_login.g.dart';

class FormLogicStateLogin {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  FormLogicStateLogin(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  FormLogicStateLogin copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) =>
      FormLogicStateLogin(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          email: email ?? this.email,
          password: password ?? this.password);
  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting,
    isFormPosted: $isFormPosted,
    isValid: $isValid,
    email: $email,
    password: $password
''';
  }
}

@riverpod
class FormLogicLogin extends _$FormLogicLogin {
  @override
  FormLogicStateLogin build() => FormLogicStateLogin();

  void onEmailChange(String value) {
    final inputEmail = Email.dirty(value);
    state = state.copyWith(
        email: inputEmail,
        isValid: Formz.validate([inputEmail, state.password]));
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  Future<(bool, String)> onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) {}
    if (kDebugMode) {
      print(state);
    }

    return (true, 'ok');
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }
}
