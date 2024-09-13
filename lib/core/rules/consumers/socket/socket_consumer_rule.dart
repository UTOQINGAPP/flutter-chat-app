import 'package:chat/configs/configs.dart';

abstract class SocketConsumerRule {
  Future<void> connect();
  Future<void> disconnect();
  Socket get socket;
}
