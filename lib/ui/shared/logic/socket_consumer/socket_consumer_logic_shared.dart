import 'package:chat/configs/configs.dart';
import 'package:chat/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'socket_consumer_logic_shared.g.dart';

// Intermediary logic between the socket consumer and the UI that maintains a state,
// maintaining real-time communication with the server.
@Riverpod(keepAlive: true)
class SocketConsumerLogicShared extends _$SocketConsumerLogicShared {
  late final SocketConsumerUse _consumer;
  @override
  ServerStatus build() {
    final source = SocketSourceUse(EnvConfig.socketUrl());
    _consumer = SocketConsumerUse(source);
    return ServerStatus.connecting;
  }

  Future<void> connect() async {
    await _consumer.connect();

    _consumer.socket.on('connect', (_) {
      if (kDebugMode) {
        print('Socket connected');
      }
      state = ServerStatus.online;
    });

    _consumer.socket.on('disconnect', (_) {
      if (kDebugMode) {
        print('Socket disconnected');
      }
      state = ServerStatus.offline;
    });

    _consumer.socket.on('connect_error', (error) {
      if (kDebugMode) {
        print('Connection error: $error');
      }
      state = ServerStatus.offline;
    });

    _consumer.socket.on('connect_timeout', (timeout) {
      if (kDebugMode) {
        print('Connection timeout: $timeout');
      }
      state = ServerStatus.offline;
    });

    _consumer.socket.on('reconnect_failed', (_) {
      if (kDebugMode) {
        print('Reconnection failed');
      }
      state = ServerStatus.offline;
    });
  }

  Future<void> disconnect() async {
    _consumer.disconnect();
    state = ServerStatus.offline;
  }

  Socket get socket => _consumer.socket;
}
