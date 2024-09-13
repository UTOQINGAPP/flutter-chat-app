import 'package:flutter/material.dart';

// This is a personalized component, using the Widget Elevatedbutton.
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
        elevation: const WidgetStatePropertyAll<double>(2),
        backgroundColor: onPressed != null
            ? const WidgetStatePropertyAll<Color>(Colors.blue)
            : const WidgetStatePropertyAll<Color>(Colors.grey),
        shape: const WidgetStatePropertyAll<OutlinedBorder>(StadiumBorder()),
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
