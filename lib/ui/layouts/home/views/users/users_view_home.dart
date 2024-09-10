import 'package:chat/configs/configs.dart';
import 'package:chat/ui/layouts/home/views/users/components/components_users.dart';
import 'package:chat/ui/shared/shared_ui.dart';

class UsersViewHome extends StatefulHookConsumerWidget {
  static String link = '/home/users';
  const UsersViewHome({super.key});

  @override
  ConsumerState<UsersViewHome> createState() => _UsersViewHomeState();
}

class _UsersViewHomeState extends ConsumerState<UsersViewHome> {
  List<UserModelShared> usuarios = List.generate(5, (index) {
    return UserModelShared(
      online: index % 2 == 0,
      email: 'usuario$index@example.com',
      name: 'Usuario $index',
      uid: 'UID$index',
    );
  });
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      usuarios += List.generate(5, (index) {
        return UserModelShared(
          online: index % 2 == 0,
          email: 'usuario${usuarios.length + index}@example.com',
          name: 'Usuario ${usuarios.length + index}',
          uid: 'UID${usuarios.length + index}',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return UserComponentUsers(
                  user: usuarios[index],
                );
              },
              childCount: usuarios.length,
            ),
          ),
        ],
      ),
    );
  }
}
