import 'package:chat/ui/layouts/authentication/components/components_authentication.dart';
import 'package:chat/ui/layouts/authentication/views/login/login_view_authentication.dart';
import 'package:chat/ui/layouts/authentication/views/register/logic/logic_register.dart';
import 'package:chat/ui/shared/shared_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterViewAuthentication extends ConsumerWidget {
  static String link = '/authentication/register';
  const RegisterViewAuthentication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FormLogicStateRegister formLogicStateRegister =
        ref.watch(formLogicRegisterProvider);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInputComponentShared(
            icon: Icons.person,
            placeholder: 'Nombre completo',
            keyboardType: TextInputType.name,
            onChanged: (value) => ref
                .read(formLogicRegisterProvider.notifier)
                .onFullNameChange(value),
            errorText: formLogicStateRegister.fullName.errorMessage,
          ),
          CustomInputComponentShared(
            icon: Icons.email,
            placeholder: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => ref
                .read(formLogicRegisterProvider.notifier)
                .onEmailChange(value),
            errorText: formLogicStateRegister.email.errorMessage,
          ),
          CustomInputComponentShared(
            icon: Icons.key,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.text,
            isPassword: true,
            onChanged: (value) => ref
                .read(formLogicRegisterProvider.notifier)
                .onPasswordChange(value),
            errorText: formLogicStateRegister.password.errorMessage,
          ),
          ElevatedButtonComponentAuthentication(
            label: 'Registrarse',
            onPressed: () {
              ref.read(formLogicRegisterProvider.notifier).onFormSubmit();
              formLogicStateRegister.toString();
            },
          ),
          const SizedBox(height: 60),
          LabelsComponentAuthentication(
            title: '¿Tienes una cuenta?',
            subTitle: 'Ingresa ahora!',
            link: LoginViewAuthentication.link,
          ),
        ],
      ),
    );
  }
}
