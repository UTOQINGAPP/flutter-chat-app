import 'package:chat/configs/configs.dart';
import 'package:chat/core/rules/rules_core.dart';
import 'package:flutter/foundation.dart';

class SocketSourceUse implements SocketSourceRule {
  late Socket _socket;
  final String url;

  SocketSourceUse(this.url);

  @override
  Future<void> connect() async {
    final String? token = await TokenSecureStorageHelperConfig.getToken();

    _socket = io(url, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      //'extraHeaders': {'x-token': token},
      'query': {'token': token}
    });

    _socket.on('connect', (_) {
      if (kDebugMode) {
        print('Connected');
      }
    });

    _socket.on('disconnect', (_) {
      if (kDebugMode) {
        print('Disconnected');
      }
    });

    _socket.on('connect_error', (error) {
      if (kDebugMode) {
        print('Connection error: $error');
      }
    });

    _socket.on('connect_timeout', (timeout) {
      if (kDebugMode) {
        print('Connection timeout: $timeout');
      }
    });

    _socket.on('reconnect_failed', (_) {
      if (kDebugMode) {
        print('Reconnection failed');
      }
    });
  }

  @override
  Future<void> disconnect() async {
    _socket.disconnect();
  }

  @override
  Socket get socket => _socket;
}
