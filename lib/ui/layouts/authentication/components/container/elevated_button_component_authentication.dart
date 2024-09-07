import 'package:flutter/material.dart';

class ElevatedButtonComponentAuthentication extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const ElevatedButtonComponentAuthentication(
      {super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll<double>(2),
        backgroundColor: onPressed != null
            ? WidgetStatePropertyAll<Color>(Colors.blue)
            : WidgetStatePropertyAll<Color>(Colors.grey),
        shape: WidgetStatePropertyAll<OutlinedBorder>(StadiumBorder()),
      ),
      child: SizedBox(
          width: double.infinity,
          height: 55,
          child: Center(
              child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ))),
    );
  }
}
