import 'package:chat/configs/configs.dart';
import 'package:flutter/foundation.dart';
export 'views/views_authentication.dart';

class AuthenticationLayout extends HookWidget {
  final StatefulNavigationShell navigationShell;
  const AuthenticationLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<double> widthWeb = useState(context.width(50));
    final ChangeSizeScreenHelperConfig changeSizeScreenHelperConfig =
        ChangeSizeScreenHelperConfig();
    if (changeSizeScreenHelperConfig.isLargeScreen(context)) {
      widthWeb.value = context.width(50);
    } else if (changeSizeScreenHelperConfig.isMediumScreen(context)) {
      widthWeb.value = context.width(70);
    } else if (changeSizeScreenHelperConfig.isSmallScreen(context)) {
      widthWeb.value = context.width(100);
    }
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: kIsWeb ? widthWeb.value : context.width(100),
              child: Column(
                children: [
                  const _LogoViewAuthentication(),
                  navigationShell,
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
                  ),
                ],
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
