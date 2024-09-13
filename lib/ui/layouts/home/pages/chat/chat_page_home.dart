import 'dart:io';

import 'package:chat/configs/configs.dart';
import 'package:chat/core/core.dart';
import 'package:chat/ui/layouts/home/pages/chat/components/components_chat.dart';
import 'package:chat/ui/shared/shared_ui.dart';

class ChatPageHome extends StatefulHookConsumerWidget {
  static String link = '/home/chat';
  const ChatPageHome({super.key});

  @override
  ConsumerState<ChatPageHome> createState() => _ChatPageHomeState();
}

class _ChatPageHomeState extends ConsumerState<ChatPageHome>
    with TickerProviderStateMixin {
  late List<MessageComponentChat> messages;
  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = useFocusNode();
    TextEditingController messageController = useTextEditingController();
    ValueNotifier<bool> isWriting = useState(false);
    UserEntityRule userTo = ref.watch(userToLogicSharedProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Platform.isIOS
            ? null
            : IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: Text(
                userTo.name.substring(0, 2),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              userTo.name,
              style: const TextStyle(color: Colors.black87, fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _messagesView(),
          const Divider(height: 1),
          _inputMessageView(
            messageController: messageController,
            focusNode: focusNode,
            isWriting: isWriting,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    messages = [];
    _loadHistory(ref.read(userToLogicSharedProvider).uid);
    ref
        .read(socketConsumerLogicSharedProvider.notifier)
        .socket
        .on('personal-message', (payload) => listenToMessage(payload));

    super.initState();
  }

  Future _loadHistory(String userUid) async {
    if (!mounted) {
      return;
    }

    await ref
        .read(chatConsumerLogicSharedProvider.notifier)
        .getMessages(userUid);

    final history = ref
        .read(chatConsumerLogicSharedProvider)
        .map((message) => MessageComponentChat(
              animationController: AnimationController(
                vsync: this,
                duration: const Duration(milliseconds: 200),
              )..forward(),
              data: MessageEntityRule(
                  fromUid: message.fromUid,
                  toUid: message.toUid,
                  message: message.message),
              uid: ref.read(userLogicSharedProvider).uid,
            ))
        .toList();
    setState(() {
      messages.insertAll(0, history);
    });
  }

  void listenToMessage(dynamic payload) async {
    if (!mounted) {
      return;
    }

    final user = ref.read(userLogicSharedProvider);
    final uid = user.uid;

    final MessageComponentChat messageCreate = MessageComponentChat(
      uid: uid,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
      data: MessageEntityRule(
        fromUid: payload['from'],
        toUid: payload['to'],
        message: payload['message'],
      ),
    );
    messages.insert(0, messageCreate);
    setState(() {});
    messageCreate.animationController.forward();
  }

  SafeArea _inputMessageView({
    required TextEditingController messageController,
    required FocusNode focusNode,
    required ValueNotifier<bool> isWriting,
  }) {
    return SafeArea(
      child: Container(
        height: 50,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: messageController,
                onSubmitted: (_) => _handleSubmitLogic(
                  messageController: messageController,
                  focusNode: focusNode,
                  isWriting: isWriting,
                ),
                onChanged: (value) {
                  if (value.trim().isNotEmpty) {
                    isWriting.value = true;
                  } else {
                    isWriting.value = false;
                  }
                },
                decoration:
                    const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      onPressed: isWriting.value
                          ? () => _handleSubmitLogic(
                                messageController: messageController,
                                focusNode: focusNode,
                                isWriting: isWriting,
                              )
                          : null,
                      child: const Text('Enviar'),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: isWriting.value
                              ? () => _handleSubmitLogic(
                                    messageController: messageController,
                                    focusNode: focusNode,
                                    isWriting: isWriting,
                                  )
                              : null,
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible _messagesView() {
    return Flexible(
      child: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return messages[index];
        },
      ),
    );
  }

  _handleSubmitLogic({
    required TextEditingController messageController,
    required FocusNode focusNode,
    required ValueNotifier<bool> isWriting,
  }) {
    UserEntityRule? userTo = ref.read(userToLogicSharedProvider);
    UserEntityRule? user = ref.read(userLogicSharedProvider);
    if (messageController.text.isEmpty) return;
    if (userTo == null) return;
    if (user == null) return;

    final MessageComponentChat messageCreate = MessageComponentChat(
      uid: user.uid,
      animationController: AnimationController(
          duration: const Duration(milliseconds: 200), vsync: this),
      data: MessageEntityRule(
        fromUid: user.uid,
        toUid: userTo.uid,
        message: messageController.text,
      ),
    );
    messages.insert(0, messageCreate);
    messageCreate.animationController.forward();
    ref.read(socketConsumerLogicSharedProvider.notifier).socket.emit(
        'personal-message', {
      'from': user.uid,
      'to': userTo.uid,
      'message': messageController.text
    });
    messageController.clear();
    focusNode.requestFocus();
    isWriting.value = false;
  }

  @override
  void dispose() {
    for (var message in messages) {
      message.animationController.dispose();
    }
    messages = [];
    super.dispose();
  }
}
