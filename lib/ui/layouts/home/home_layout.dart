import 'package:chat/configs/configs.dart';
import 'package:chat/ui/layouts/authentication/authentication_layout.dart';
import 'package:chat/ui/shared/shared_ui.dart';

export 'views/views_home.dart';
export 'pages/pages_home.dart';

class HomeLayout extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const HomeLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: navigationShell,
    );
  }
}
