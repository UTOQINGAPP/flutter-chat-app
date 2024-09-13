import 'package:chat/core/core.dart';
import 'package:flutter/material.dart';

// This is a custom component to show a user, uses the widget listile as a base.
class UserComponentHome extends StatelessWidget {
  final UserEntityRule user;
  final void Function()? onTap;
  const UserComponentHome({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.name.substring(0, 2)),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(60),
        ),
      ),
      onTap: onTap,
    );
  }
}
