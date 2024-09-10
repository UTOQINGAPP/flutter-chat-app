import 'package:chat/configs/configs.dart';

void showAlertDialogShared(BuildContext context,
    {required String title, required String subTitle}) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(subTitle),
          actions: [
            MaterialButton(
              onPressed: () => context.pop(),
              elevation: 5,
              textColor: Colors.blue,
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(subTitle),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () => context.pop(),
            )
          ],
        );
      },
    );
  }
}
