import 'package:chat/configs/configs.dart';
import 'package:chat/core/rules/rules_core.dart';

class SocketConsumerUse implements SocketConsumerRule {
  final SocketSourceRule _source;

  SocketConsumerUse(SocketSourceRule source) : _source = source;

  @override
  Future<void> connect() async {
    return _source.connect();
  }

  @override
  Future<void> disconnect() async {
    return _source.disconnect();
  }

  @override
  Socket get socket => _source.socket;
}
