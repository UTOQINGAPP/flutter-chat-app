import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LabelsComponentAuthentication extends StatelessWidget {
  final String title;
  final String subTitle;
  final String link;
  const LabelsComponentAuthentication(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.link});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => context.go(link),
          child: Text(
            subTitle,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
