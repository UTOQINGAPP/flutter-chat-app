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
        future: checkLoginState(ref, context),
      ),
    );
  }

  Future checkLoginState(WidgetRef ref, BuildContext context) async {
    // Verifying the possible routes where the user is, whether he is authenticated or not
    final bool loginRoute = state.fullPath == LoginViewAuthentication.link;
    final bool registerRoute =
        state.fullPath == RegisterViewAuthentication.link;
    final bool loadingRoute = state.fullPath == LoadingPageShared.link;
    // Performing the query to the server through consumer logic
    final authenticationConsumerLogic =
        ref.read(authenticationConsumerLogicSharedProvider);

    final isLoggingIn = await authenticationConsumerLogic.isLoggedIn();

    // Checking if the user is authenticated and a user arrives as a response from the server
    if (isLoggingIn.$1 && isLoggingIn.$2 != null) {
      ref.read(userLogicSharedProvider.notifier).update(isLoggingIn.$2!);
      await ref.read(socketConsumerLogicSharedProvider.notifier).connect();
    }

    // Verifying what condition the user meets to direct them to the corresponding interface.
    if (isLoggingIn.$1 && loginRoute && context.mounted) {
      context.go(UsersViewHome.link);
    } else if (isLoggingIn.$1 && registerRoute && context.mounted) {
      context.go(UsersViewHome.link);
    } else if (!isLoggingIn.$1 && !loginRoute && context.mounted) {
      context.go(LoginViewAuthentication.link);
    } else if (!isLoggingIn.$1 && !registerRoute && context.mounted) {
      context.go(LoginViewAuthentication.link);
    } else if (isLoggingIn.$1 && loadingRoute && context.mounted) {
      context.go(UsersViewHome.link);
    } else if (!isLoggingIn.$1 && loadingRoute && context.mounted) {
      context.go(LoginViewAuthentication.link);
    } else {
      if (context.mounted && !isLoggingIn.$1) {
        context.go(LoginViewAuthentication.link);
      }
    }
  }
}
