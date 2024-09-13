import 'package:chat/configs/configs.dart';
import 'package:flutter/foundation.dart';
export 'views/views_authentication.dart';

class AuthenticationLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AuthenticationLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.height(100),
            width: kIsWeb ? context.width(50) : context.width(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!kIsWeb) const Spacer(),
                const _LogoViewAuthentication(),
                if (!kIsWeb) navigationShell,
                if (kIsWeb) Expanded(child: navigationShell),
                if (!kIsWeb) const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      'Términos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoViewAuthentication extends StatelessWidget {
  const _LogoViewAuthentication();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Image(
              image: AssetImage(AssetsConfig().images.logo),
            ),
            const SizedBox(height: 20),
            const Text(
              'Messenger',
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
