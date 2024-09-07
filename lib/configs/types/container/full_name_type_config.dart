import 'package:formz/formz.dart';

// Define input validation errors
enum NameError { empty, invalid }

// Extend FormzInput and provide the input type and error type.
class FullName extends FormzInput<String, NameError> {
  // Call super.pure to represent an unmodified form input.
  const FullName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const FullName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameError.empty) return 'El campo es requerido';
    if (displayError == NameError.invalid) {
      return 'El nombre debe tener al menos dos palabras';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;

    // Validar que el nombre completo tenga al menos dos palabras
    final words = value.trim().split(' ');
    if (words.length < 2) return NameError.invalid;

    return null;
  }
}
