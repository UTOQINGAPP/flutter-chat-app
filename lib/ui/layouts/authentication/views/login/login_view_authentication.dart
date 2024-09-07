import 'package:chat/ui/layouts/authentication/components/components_authentication.dart';
import 'package:chat/ui/layouts/authentication/views/login/logic/logic_login.dart';
import 'package:chat/ui/layouts/authentication/views/register/register_view_authentication.dart';
import 'package:chat/ui/shared/shared_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginViewAuthentication extends ConsumerWidget {
  static String link = '/authentication/login';
  const LoginViewAuthentication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FormLogicStateLogin formLogicStateLogin = ref.watch(formLogicLoginProvider);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInputComponentShared(
            icon: Icons.email,
            placeholder: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                ref.read(formLogicLoginProvider.notifier).onEmailChange(value),
            errorText: formLogicStateLogin.email.errorMessage,
          ),
          CustomInputComponentShared(
            icon: Icons.key,
            placeholder: 'Contraseña',
            isPassword: true,
            keyboardType: TextInputType.text,
            onChanged: (value) => ref
                .read(formLogicLoginProvider.notifier)
                .onPasswordChange(value),
            errorText: formLogicStateLogin.password.errorMessage,
          ),
          ElevatedButtonComponentAuthentication(
            label: 'Iniciar Sesión',
            onPressed: () {
              ref.read(formLogicLoginProvider.notifier).onFormSubmit();
              formLogicStateLogin.toString();
            },
          ),
          const SizedBox(height: 60),
          LabelsComponentAuthentication(
            title: '¿No tienes cuenta?',
            subTitle: 'Crea un ahora!',
            link: RegisterViewAuthentication.link,
          ),
        ],
      ),
    );
  }
}
