import 'package:chat/core/core.dart';
import 'package:flutter/material.dart';

// This is a personalized component that shows a message,
// visually different depending on who sends it and who receives it.
class MessageComponentChatHome extends StatelessWidget {
  final MessageEntityRule data;
  final String uid;
  final AnimationController animationController;
  const MessageComponentChatHome({
    super.key,
    required this.uid,
    required this.data,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: selectedMessageView(),
        ),
      ),
    );
  }

  Widget? selectedMessageView() {
    if (data.fromUid == uid) {
      return _myMessageView();
    } else if (data.toUid == uid) {
      return _notMessageView();
    }
    return const Text('Mensaje de origen desconocido (x).');
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
          data.message,
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
          data.message,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
