import 'package:chat/configs/configs.dart';
import 'package:chat/ui/layouts/home/pages/pages_home.dart';
import 'package:chat/ui/layouts/home/views/users/components/components_users.dart';
import 'package:chat/ui/shared/shared_ui.dart';

class UsersViewHome extends StatefulHookConsumerWidget {
  static String link = '/home/users';
  const UsersViewHome({super.key});

  @override
  ConsumerState<UsersViewHome> createState() => _UsersViewHomeState();
}

class _UsersViewHomeState extends ConsumerState<UsersViewHome> {
  Future<void> _refresh() async {
    return ref.read(usersConsumerSharedProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersConsumerSharedProvider);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        slivers: [
          users.when(
            data: (users) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return UserComponentUsers(
                      user: users[index],
                      onTap: () {
                        ref
                            .read(userToLogicSharedProvider.notifier)
                            .update(users[index]);

                        context.push(ChatPageHome.link);
                      },
                    );
                  },
                  childCount: users.length,
                ),
              );
            },
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Text('Error al cargar los usuarios: $error'),
              ),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
