import 'package:chat/ui/layouts/home/pages/chat/models/models_chat.dart';
import 'package:flutter/material.dart';

class MessageComponentChat extends StatelessWidget {
  final MessageModelChat message;
  final String uid;
  final AnimationController animationController;
  const MessageComponentChat(
      {super.key,
      required this.message,
      required this.uid,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: message.uid == uid ? _myMessageView() : _notMessageView(),
        ),
      ),
    );
  }

  Widget _myMessageView() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 5),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          message.value,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _notMessageView() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, right: 50, left: 5),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          message.value,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
