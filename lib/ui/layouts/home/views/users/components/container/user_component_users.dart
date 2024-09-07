import 'package:chat/ui/shared/shared_ui.dart';
import 'package:flutter/material.dart';

class UserComponentUsers extends StatelessWidget {
  final UserModelShared user;
  const UserComponentUsers({super.key, required this.user});

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
    );
  }
}
