import 'package:chat/configs/configs.dart';
import 'package:chat/ui/layouts/authentication/components/components_authentication.dart';
import 'package:chat/ui/layouts/authentication/views/login/logic/logic_login.dart';
import 'package:chat/ui/layouts/authentication/views/register/register_view_authentication.dart';
import 'package:chat/ui/layouts/home/home_layout.dart';
import 'package:chat/ui/shared/shared_ui.dart';

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
            enabled: !formLogicStateLogin.isFormPosted,
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
            enabled: !formLogicStateLogin.isFormPosted,
          ),
          ElevatedButtonComponentAuthentication(
            label: 'Iniciar Sesión',
            onPressed: formLogicStateLogin.isPosting
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    (bool, String) result = await ref
                        .read(formLogicLoginProvider.notifier)
                        .onFormSubmit();

                    if (result.$1) {
                      if (context.mounted) {
                        context.go(UsersViewHome.link);
                      }
                    } else {
                      if (context.mounted) {
                        showAlertDialogShared(context,
                            title: 'Error al realizar el login',
                            subTitle: result.$2);
                      }
                    }
                    //formLogicStateLogin.toString();
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
