import 'package:flutter/material.dart';
import 'package:skill_swap/utils/constants/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:skill_swap/utils/local_storage/secure_storage.dart';

class SocketService {
  SocketService._();

  static final SocketService _instance = SocketService._();

  static SocketService get instance => _instance;

  IO.Socket? _socket;

  IO.Socket? get socket => _socket;

  bool get isConnected => _socket?.connected ?? false;

  /// Connect to Socket.IO server
  Future<void> connect() async {
    if (isConnected) return;

    try {
      final token = await getTokenSecure();
      if (token == null) throw Exception('No authentication token found');

      _socket = IO.io(
        UrlStrings.baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setAuth({'token': token})
            .build(),
      );

      _socket!.onConnect((_) {
        debugPrint('Socket connected');
      });

      _socket!.onDisconnect((_) {
        debugPrint('Socket disconnected');
      });

      _socket!.onError((error) {
        debugPrint('Socket error: $error');
      });

      _socket!.connect();
    } catch (e) {
      debugPrint('Error connecting to socket: $e');
      rethrow;
    }
  }

  /// Disconnect from Socket.IO server
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null;
    }
  }

  /// Send a message to another user
  void sendMessage({
    required String toUserId,
    required String content,
  }) {
    if (!isConnected) {
      debugPrint('Socket not connected');
      return;
    }
    _socket!.emit('send_message', {
      'toUserId': toUserId,
      'content': content,
    });
  }

  /// Listen for incoming messages
  void onReceiveMessage(Function(Map<String, dynamic>) callback) {
    _socket?.on('receive_message', (data) {
      callback(data as Map<String, dynamic>);
    });
  }

  /// Listen for message sent confirmation
  void onMessageSent(Function(Map<String, dynamic>) callback) {
    _socket?.on('message_sent', (data) {
      callback(data as Map<String, dynamic>);
    });
  }

  /// Remove all listeners
  void removeAllListeners() {
    _socket?.off('receive_message');
    _socket?.off('message_sent');
  }
}
