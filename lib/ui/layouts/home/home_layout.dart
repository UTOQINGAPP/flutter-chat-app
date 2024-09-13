import 'package:chat/configs/configs.dart';
import 'package:chat/ui/layouts/authentication/authentication_layout.dart';
import 'package:chat/ui/shared/shared_ui.dart';
import 'package:flutter/foundation.dart';

export 'views/views_home.dart';
export 'pages/pages_home.dart';

class HomeLayout extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const HomeLayout({super.key, required this.navigationShell});

  @override
  ConsumerState<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends ConsumerState<HomeLayout> {
  @override
  void initState() {
    if (kIsWeb) {
      getUser();
    }
    super.initState();
  }

  Future getUser() async {
    // Performing the query to the server through consumer logic
    final authenticationConsumerLogic =
        ref.read(authenticationConsumerLogicSharedProvider);

    final isLoggingIn = await authenticationConsumerLogic.isLoggedIn();

    // Checking if the user is authenticated and a user arrives as a response from the server
    if (isLoggingIn.$1 && isLoggingIn.$2 != null) {
      await ref.read(userLogicSharedProvider.notifier).update(isLoggingIn.$2!);
      await ref.read(socketConsumerLogicSharedProvider.notifier).connect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(userLogicSharedProvider).name),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () async {
            bool result = await ref
                .read(authenticationConsumerLogicSharedProvider)
                .logout();
            ref.read(socketConsumerLogicSharedProvider.notifier).disconnect();
            if (!result) {
              return;
            }
            if (context.mounted) {
              context.go(LoginViewAuthentication.link);
            }
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          IconButton(
              onPressed: () {
                return ref.read(usersConsumerSharedProvider.notifier).refresh();
              },
              icon: const Icon(Icons.refresh)),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ref.watch(socketConsumerLogicSharedProvider) ==
                    ServerStatus.online
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[400],
                  )
                : const Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
      body: widget.navigationShell,
    );
  }
}
