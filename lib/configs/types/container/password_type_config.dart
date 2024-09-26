import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class Password extends FormzInput<String, PasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{9,}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Password.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Password.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordError.empty) return 'El campo es requerido';
    if (displayError == PasswordError.length) return 'Mínimo 9 caracteres';
    if (displayError == PasswordError.format) {
      return 'Debe de tener Mayúscula, Minusculas, números y caracteres especiales';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if (value.length < 9) return PasswordError.length;
    if (!passwordRegExp.hasMatch(value)) return PasswordError.format;

    return null;
  }
}
