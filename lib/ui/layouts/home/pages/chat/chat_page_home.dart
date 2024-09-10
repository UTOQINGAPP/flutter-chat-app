import 'package:chat/configs/configs.dart';
import 'package:chat/ui/layouts/home/pages/chat/components/components_chat.dart';
import 'package:chat/ui/layouts/home/pages/chat/models/models_chat.dart';

/* List<MessageModelChat> messagesModel = [
  MessageModelChat(value: "Suena interesante.", uid: "user456"),
  MessageModelChat(value: "Trabajando en un proyecto.", uid: "user123"),
  MessageModelChat(value: "¿Qué has hecho hoy?", uid: "user456"),
  MessageModelChat(value: "Todo bien, gracias.", uid: "user123"),
  MessageModelChat(value: "Bien, ¿y tú?", uid: "user456"),
  MessageModelChat(value: "Hola, ¿cómo estás?", uid: "user123"),
]; */

class ChatPageHome extends StatefulHookWidget {
  static String link = '/home/chat';
  const ChatPageHome({super.key});

  @override
  State<ChatPageHome> createState() => _ChatPageHomeState();
}

class _ChatPageHomeState extends State<ChatPageHome>
    with TickerProviderStateMixin {
  List<MessageComponentChat> messages = [];
  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = useFocusNode();
    TextEditingController messageController = useTextEditingController();
    ValueNotifier<bool> isWriting = useState(false);

    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: const Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'Teodoro Martinez',
              style: TextStyle(color: Colors.black87, fontSize: 12),
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

  SafeArea _inputMessageView({
    required TextEditingController messageController,
    required FocusNode focusNode,
    required ValueNotifier<bool> isWriting,
  }) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 50,
        color: Colors.white,
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: messageController,
                onSubmitted: (_) => _handleSubmitLogic(
                  messageController: messageController,
                  focusNode: focusNode,
                  isWriting: isWriting,
                  uid: 'user123',
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
                                uid: 'user123',
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
                                    uid: 'user123',
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
    required String uid,
  }) {
    if (messageController.text.isEmpty) return;
    final MessageComponentChat messageCreate = MessageComponentChat(
      message: MessageModelChat(value: messageController.text, uid: uid),
      uid: uid,
      animationController: AnimationController(
          duration: const Duration(milliseconds: 200), vsync: this),
    );
    messages.insert(0, messageCreate);
    messageCreate.animationController.forward();
    messageController.clear();
    focusNode.requestFocus();
    isWriting.value = false;
  }

  @override
  void dispose() {
    for (var message in messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
