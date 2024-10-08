import 'package:chat/configs/configs.dart';
import 'package:chat/ui/shared/shared_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'form_logic_register.g.dart';

// Personalized registration form.
class FormLogicStateRegister {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;

  final Uint8List? avatar;
  final FullName fullName;
  final Email email;
  final Password password;

  FormLogicStateRegister({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.avatar,
  });

  FormLogicStateRegister copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    FullName? fullName,
    Email? email,
    Password? password,
    Uint8List? avatar,
  }) =>
      FormLogicStateRegister(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        avatar: avatar,
      );

  @override
  String toString() {
    return '''
  RegisterFormState:
    isPosting: $isPosting,
    isFormPosted: $isFormPosted,
    isValid: $isValid,
    avatar: $avatar,
    fullName: $fullName,  // Mostrar el fullName
    email: $email,
    password: $password,
''';
  }
}

//Logic that manages the status of the fomurge and verifies that the conditions are met and then proceed to register.
@riverpod
class FormLogicRegister extends _$FormLogicRegister {
  @override
  FormLogicStateRegister build() => FormLogicStateRegister();

  void onFullNameChange(String value) {
    final newFullName = FullName.dirty(value);
    state = state.copyWith(
        fullName: newFullName,
        isValid: Formz.validate([
          newFullName,
          state.email,
          state.password,
        ]));
  }

  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate([
          state.fullName,
          newEmail,
          state.password,
        ]));
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([
          state.fullName,
          state.email,
          newPassword,
        ]));
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
      final response = await authenticationConsumerLogic.register(
        state.fullName.value,
        state.email.value,
        state.password.value,
      );
      ref.read(userLogicSharedProvider.notifier).update(response.$2);
      state = state.copyWith(isPosting: false, isFormPosted: false);
      if (response.$1) {
        ref.read(socketConsumerLogicSharedProvider.notifier).connect();
        return (response.$1, 'Registro exitoso');
      }
    } catch (e) {
      state = state.copyWith(isPosting: false, isFormPosted: false);
      return (false, e.toString());
    }
    return (false, 'Unknown error');
  }

  void _touchEveryField() {
    final FullName fullName = FullName.dirty(state.fullName.value);
    final Email email = Email.dirty(state.email.value);
    final Password password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      fullName: fullName,
      email: email,
      password: password,
      isValid: Formz.validate([
        fullName,
        email,
        password,
      ]),
    );
  }
}
