import 'package:flutter/material.dart';

class CustomInputComponentShared extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextInputType keyboardType;
  final bool isPassword;
  final void Function(String value)? onChanged;
  final String? errorText;
  final bool enabled;
  const CustomInputComponentShared({
    super.key,
    required this.icon,
    required this.placeholder,
    this.keyboardType = TextInputType.emailAddress,
    this.isPassword = false,
    this.onChanged,
    this.errorText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 5),
                  blurRadius: 5,
                )
              ],
            ),
            child: TextField(
              autocorrect: false,
              keyboardType: keyboardType,
              obscureText: isPassword,
              onChanged: onChanged,
              enabled: enabled,
              decoration: InputDecoration(
                prefixIcon: Icon(icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: placeholder,
              ),
            ),
          ),
          if (errorText != null) const SizedBox(height: 5),
          if (errorText != null)
            Text(
              errorText!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
