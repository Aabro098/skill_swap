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
  bool _connectionInProgress = false;
  bool _socketCreated = false;

  /// Connect to Socket.IO server
  Future<void> connect() async {
    // Prevent multiple connection attempts
    if (isConnected) {
      debugPrint('Socket already connected, skipping...');
      return;
    }

    if (_connectionInProgress) {
      debugPrint('Connection already in progress, skipping...');
      return;
    }

    if (_socketCreated) {
      debugPrint('Socket already created, attempting to reconnect...');
      _socket?.connect();
      return;
    }

    _connectionInProgress = true;
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

      _socketCreated = true;

      _socket!.onConnect((_) {
        _connectionInProgress = false;
        debugPrint('✅ Socket connected');
      });

      _socket!.onDisconnect((_) {
        _connectionInProgress = false;
        debugPrint('❌ Socket disconnected');
      });

      _socket!.onConnectError((error) {
        _connectionInProgress = false;
        debugPrint('🔴 Socket connection error: $error');
      });

      _socket!.onError((error) {
        debugPrint('🔴 Socket error: $error');
      });

      // Debug: Log all socket events
      _socket!.onAny((event, data) {
        debugPrint('🔍 Socket event received: "$event" with data: $data');
      });

      _socket!.connect();
    } catch (e) {
      _connectionInProgress = false;
      _socketCreated = false;
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
    required String name,
    required String profileUrl,
  }) {
    debugPrint('📤 Sending message - Socket connected: ${isConnected}');
    if (!isConnected) {
      debugPrint('❌ Socket not connected');
      return;
    }
    debugPrint('📤 Emitting send_message event');
    _socket!.emit('send_message', {
      'toUserId': toUserId,
      'content': content,
      'name': name,
      'profileUrl': profileUrl,
    });
    debugPrint('📤 Message emitted successfully');
  }

  /// Listen for incoming messages
  void onReceiveMessage(Function(Map<String, dynamic>) callback) {
    debugPrint('🔧 Registering socket listener for "receive_message" event');
    debugPrint('🔧 Socket connected: ${_socket?.connected ?? false}');
    _socket?.on('receive_message', (data) {
      debugPrint('🎯 Socket received "receive_message" event with data: $data');
      callback(data as Map<String, dynamic>);
    });
  }

  /// Listen for message sent confirmation
  void onMessageSent(Function(Map<String, dynamic>) callback) {
    debugPrint('🔧 Registering socket listener for "message_sent" event');
    _socket?.on('message_sent', (data) {
      debugPrint('🎯 Socket received "message_sent" event with data: $data');
      callback(data as Map<String, dynamic>);
    });
  }

  /// Remove all listeners
  void removeAllListeners() {
    _socket?.off('receive_message');
    _socket?.off('message_sent');
  }
}
