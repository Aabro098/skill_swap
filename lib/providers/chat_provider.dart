import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/controller/chat_controller.dart';
import 'package:skill_swap/model/chat_list_model.dart';
import 'package:skill_swap/model/user_model.dart';
import 'package:skill_swap/services/socket_service.dart';

class ChatProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ChatModel> _chatList = [];
  List<ChatModel> get chatList => _chatList;

  set loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  set isFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

  bool _socketListenersInitialized = false;

  // Set to track received message IDs and prevent duplicates
  final Set<String> _receivedMessageIds = {};

  // Map to track callbacks for specific conversations
  final Map<String, Function(MessageModel)> _conversationCallbacks = {};

  /// Register a callback to listen for new messages in a specific conversation
  void onNewMessage(String conversationId, Function(MessageModel) callback) {
    debugPrint('📱 Registering callback for conversation: $conversationId');
    _conversationCallbacks[conversationId] = callback;
    debugPrint(
        '📱 Total active conversation listeners: ${_conversationCallbacks.length}');
  }

  /// Unregister a callback for a specific conversation
  void offNewMessage(String conversationId) {
    debugPrint('📱 Unregistering callback for conversation: $conversationId');
    _conversationCallbacks.remove(conversationId);
  }

  Future<void> fetchChatList() async {
    loading = true;
    try {
      final response = await ChatController.instance.getChatList();
      _chatList = response;
      notifyListeners();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

  Future<List<MessageModel>> fetchChatHistory({required String id}) async {
    isFetching = true;
    try {
      final response = await ChatController.instance.getChatHistory(id: id);
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      isFetching = false;
    }
  }

  /// Initialize socket event listeners for real-time messaging
  void initializeSocketListeners() {
    // Prevent duplicate listener registration
    if (_socketListenersInitialized) {
      debugPrint('⚠️ Socket listeners already initialized, skipping...');
      return;
    }

    _socketListenersInitialized = true;
    debugPrint('📤 Initializing socket listeners...');

    // Listen for incoming messages
    SocketService.instance.onReceiveMessage((message) {
      debugPrint('🔔 Socket event triggered for receive_message');
      _handleIncomingMessage(message);
    });

    // Listen for message sent confirmation
    SocketService.instance.onMessageSent((confirmation) {
      debugPrint('🔔 Socket event triggered for message_sent');
      _handleMessageSent(confirmation);
    });

    debugPrint('✅ Socket listeners initialized successfully');
  }

  /// Handle incoming message from socket
  void _handleIncomingMessage(Map<String, dynamic> messageData) {
    try {
      debugPrint('ChatProvider: Message received: $messageData');

      final messageId = messageData['_id'] as String?;

      // Check if we've already processed this message
      if (messageId != null && _receivedMessageIds.contains(messageId)) {
        debugPrint('⚠️ Duplicate message received, skipping: $messageId');
        return;
      }

      // Create a message model from the incoming data
      final newMessage = MessageModel(
        id: messageId,
        content: messageData['content'] as String?,
        timestamp: messageData['timestamp'] != null
            ? DateTime.tryParse(messageData['timestamp'] as String)
            : DateTime.now(),
        fromSelf: false, // This is a received message
      );

      final senderId = messageData['sender'] as String?;
      if (senderId == null) {
        debugPrint('❗️ Sender ID is null');
        return;
      }

      // Mark this message as received
      if (messageId != null) {
        _receivedMessageIds.add(messageId);
      }

      // Invoke the callback for this specific conversation
      final conversationCallback = _conversationCallbacks[senderId];
      debugPrint('📱 Looking for callback for senderId: $senderId');
      debugPrint(
          '📱 Available callbacks: ${_conversationCallbacks.keys.toList()}');
      if (conversationCallback != null) {
        debugPrint('✅ Callback found, invoking for senderId: $senderId');
        conversationCallback(newMessage);
      } else {
        debugPrint('❌ No callback registered for senderId: $senderId');
      }

      // Check if the sender is already in the chat list
      final existingChatIndex =
          _chatList.indexWhere((chat) => chat.user.id == senderId);

      if (existingChatIndex != -1) {
        // Update existing chat with the new message
        final existingChat = _chatList[existingChatIndex];
        _chatList[existingChatIndex] = existingChat.copyWith(
          lastMessage: newMessage,
        );
        debugPrint('✅ Chat updated for user: $senderId');
      } else {
        // Create a new chat for this user
        final senderName = messageData['senderName'] as String? ?? 'Unknown';
        final senderProfileUrl =
            messageData['senderProfileUrl'] as String? ?? '';

        final newChat = ChatModel(
          user: UserModel(
            id: senderId,
            name: senderName,
            email: '', // Email not provided from socket
            description: '', // Description not provided from socket
            profileUrl: senderProfileUrl,
            skills: const [],
            requestedSkills: const [],
            isPremiumUser: false,
          ),
          lastMessage: newMessage,
        );

        // Add the new chat to the beginning of the list
        _chatList.insert(0, newChat);
        debugPrint('✅ New chat created and added for user: $senderId');
      }

      notifyListeners();
    } catch (e) {
      debugPrint('❗️ Error handling incoming message: $e');
    }
  }

  /// Handle message sent confirmation from socket
  void _handleMessageSent(Map<String, dynamic> confirmationData) {
    try {
      debugPrint('ChatProvider: Message sent confirmation: $confirmationData');

      final receiverId = confirmationData['receiver'] as String?;
      final messageId = confirmationData['_id'] as String?;

      if (receiverId == null) {
        debugPrint('❗️ Receiver ID is null');
        return;
      }

      // Create a message model from the confirmation data
      final sentMessage = MessageModel(
        id: messageId,
        content: confirmationData['content'] as String?,
        timestamp: confirmationData['timestamp'] != null
            ? DateTime.tryParse(confirmationData['timestamp'] as String)
            : DateTime.now(),
        fromSelf: true, // This is a sent message
      );

      // Remove from pending messages if it exists
      if (messageId != null) {
        _pendingMessages.remove(messageId);
      }

      // Find the chat with this receiver
      final chatIndex =
          _chatList.indexWhere((chat) => chat.user.id == receiverId);

      if (chatIndex != -1) {
        final chat = _chatList[chatIndex];
        final updatedChat = chat.copyWith(lastMessage: sentMessage);

        // Remove from current position and add to the top
        _chatList.removeAt(chatIndex);
        _chatList.insert(0, updatedChat);

        debugPrint('✅ Message confirmed for user: $receiverId');
      } else {
        debugPrint('⚠️ Chat not found for receiver: $receiverId');
      }

      notifyListeners();
    } catch (e) {
      debugPrint('❗️ Error handling message sent confirmation: $e');
    }
  }

  /// Map to track messages being sent (pending confirmation)
  final Map<String, MessageModel> _pendingMessages = {};

  /// Get pending messages
  Map<String, MessageModel> get pendingMessages => _pendingMessages;

  /// Check if a message ID is pending confirmation
  bool isPendingMessage(String? messageId) =>
      messageId != null && _pendingMessages.containsKey(messageId);

  /// Send a message through socket
  void sendMessage({
    required String toUserId,
    required String content,
    required String name,
    required String profileUrl,
  }) {
    if (SocketService.instance.isConnected) {
      // Create a temporary ID for tracking
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();

      // Store the pending message
      _pendingMessages[tempId] = MessageModel(
        id: tempId,
        content: content,
        timestamp: DateTime.now(),
        fromSelf: true,
      );

      SocketService.instance.sendMessage(
        toUserId: toUserId,
        content: content,
        name: name,
        profileUrl: profileUrl,
      );

      debugPrint('📤 Message sent with tempId: $tempId');
    } else {
      debugPrint('❗️ Socket is not connected');
    }
  }
}
