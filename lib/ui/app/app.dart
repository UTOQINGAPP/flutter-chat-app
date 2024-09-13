import 'package:chat/configs/configs.dart';

// This is the Widget Father and the first to start.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      routerConfig: routerConfig(ref),
    );
  }
}
