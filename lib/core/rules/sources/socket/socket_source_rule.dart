import 'package:socket_io_client/socket_io_client.dart';

abstract class SocketSourceRule {
  Future<void> connect();
  Future<void> disconnect();
  Socket get socket;
}
