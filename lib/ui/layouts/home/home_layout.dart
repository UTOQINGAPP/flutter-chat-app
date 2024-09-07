import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
export 'views/views_home.dart';
export 'pages/pages_home.dart';

class HomeLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const HomeLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi nombre'),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            /* child: Icon(
              Icons.check_circle,
              color: Colors.blue[400],
            ), */
            child: const Icon(
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
