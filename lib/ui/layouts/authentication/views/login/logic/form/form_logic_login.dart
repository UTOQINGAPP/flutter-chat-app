import 'package:chat/configs/configs.dart';
import 'package:chat/ui/shared/shared_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'form_logic_login.g.dart';

// Personalized login form.
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

// Logic that manages the status of the fomurge and verifies that the conditions are met and then proceed to carry out the login.
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

    if (!state.isValid) {
      return (false, 'Invalid data');
    }
    try {
      state = state.copyWith(isPosting: true, isFormPosted: true);
      final authenticationConsumerLogic =
          ref.read(authenticationConsumerLogicSharedProvider);
      final response = await authenticationConsumerLogic.login(
        state.email.value,
        state.password.value,
      );
      ref.read(userLogicSharedProvider.notifier).update(response.$2);
      state = state.copyWith(isPosting: false, isFormPosted: false);

      if (response.$1) {
        ref.read(socketConsumerLogicSharedProvider.notifier).connect();
        return (response.$1, 'Login exitoso');
      }
    } catch (e) {
      state = state.copyWith(isPosting: false, isFormPosted: false);

      return (false, e.toString());
    }
    return (false, 'Unknown error');
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
