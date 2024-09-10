import 'package:chat/configs/configs.dart';
import 'package:chat/ui/layouts/layouts_ui.dart';
import 'package:chat/ui/shared/logic/logic_shared.dart';

class LoadingPageShared extends ConsumerWidget {
  static String link = '/loading';
  final GoRouterState state;
  const LoadingPageShared({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
        future: checkLoginState(ref),
      ),
    );
  }

  Future checkLoginState(WidgetRef ref) async {
    final bool loginRoute = state.fullPath == LoginViewAuthentication.link;
    final bool registerRoute =
        state.fullPath == RegisterViewAuthentication.link;
    final bool loadingRoute = state.fullPath == LoadingPageShared.link;

    final authenticationConsumerLogic =
        ref.read(authenticationConsumerLogicSharedProvider);
    final isLoggingIn = await authenticationConsumerLogic.isLoggedIn();

    if (isLoggingIn != null) {
      if (isLoggingIn.ok && loginRoute && ref.context.mounted) {
        ref.context.go(UsersViewHome.link);
      } else if (isLoggingIn.ok && registerRoute && ref.context.mounted) {
        ref.context.go(UsersViewHome.link);
      } else if (!isLoggingIn.ok && !loginRoute && ref.context.mounted) {
        ref.context.go(LoginViewAuthentication.link);
      } else if (!isLoggingIn.ok && !registerRoute && ref.context.mounted) {
        ref.context.go(LoginViewAuthentication.link);
      } else if (isLoggingIn.ok && loadingRoute && ref.context.mounted) {
        ref.context.go(UsersViewHome.link);
      } else if (!isLoggingIn.ok && loadingRoute && ref.context.mounted) {
        ref.context.go(LoginViewAuthentication.link);
      } else {
        if (ref.context.mounted && !isLoggingIn.ok) {
          ref.context.go(LoginViewAuthentication.link);
        }
      }
    } else {
      if (ref.context.mounted) {
        ref.context.go(LoginViewAuthentication.link);
      }
    }
  }
}
