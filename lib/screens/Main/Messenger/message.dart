import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/common/reusables/message_card.dart';
import 'package:skill_swap/common/reusables/search_text.dart';
import 'package:skill_swap/common/widgets/messenger_appbar.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/chat_list_model.dart';
import 'package:skill_swap/providers/chat_provider.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({
    super.key,
    required this.id,
    required this.name,
    this.photoUrl,
  });
  final String id;
  final String name;
  final String? photoUrl;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<MessageModel> chatMessages = [];
  late TextEditingController messageController;
  late ScrollController scrollController;
  late ChatProvider chatProvider;
  bool isSendingMessage = false;

  @override
  void initState() {
    super.initState();
    debugPrint('🟢 MessageScreen initState called for ID: ${widget.id}');
    messageController = TextEditingController();
    scrollController = ScrollController();
    // Save ChatProvider reference for use in dispose
    chatProvider = context.read<ChatProvider>();
    // Try-catch to ensure listener setup doesn't fail silently
    try {
      _setupNewMessageListener();
    } catch (e) {
      debugPrint('❌ Error setting up listener: $e');
    }
    // Delay message fetching until after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setMessages();
    });
  }

  void _setupNewMessageListener() {
    // Register callback for this specific conversation (using the user id as conversation id)
    debugPrint(
        '📲 Setting up message listener for conversation ID: ${widget.id}');
    try {
      debugPrint('✅ ChatProvider found: ${chatProvider.hashCode}');
      chatProvider.onNewMessage(widget.id, (MessageModel message) {
        debugPrint('📨 New message received in UI for ID: ${widget.id}');
        if (mounted) {
          setState(() {
            chatMessages.add(message);
          });
          // Scroll to bottom after new message
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        }
      });
      debugPrint('✅ Callback registered successfully for ID: ${widget.id}');
    } catch (e) {
      debugPrint('❌ Error in _setupNewMessageListener: $e');
    }
  }

  void _scrollToBottom() {
    try {
      if (scrollController.hasClients &&
          scrollController.positions.length == 1) {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
      }
    } catch (e) {
      debugPrint('Error scrolling to bottom: $e');
    }
  }

  @override
  void dispose() {
    // Unregister the callback for this conversation using saved reference
    chatProvider.offNewMessage(widget.id);
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> setMessages() async {
    final messages =
        await context.read<ChatProvider>().fetchChatHistory(id: widget.id);
    if (mounted) {
      setState(() {
        chatMessages = messages;
      });
      // Scroll to bottom after loading messages
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  Future<void> _sendMessage() async {
    final message = messageController.text.trim();
    if (message.isEmpty) {
      return;
    }

    if (isSendingMessage) return; // Prevent multiple sends

    if (mounted) {
      setState(() {
        isSendingMessage = true;
      });
    }

    try {
      final tempMessage = MessageModel(
        content: message,
        timestamp: DateTime.now(),
        fromSelf: true,
      );
      if (mounted) {
        setState(() {
          chatMessages.add(tempMessage);
        });
      }

      context.read<ChatProvider>().sendMessage(
            toUserId: widget.id,
            content: message,
            name: widget.name,
            profileUrl: widget.photoUrl ?? '',
          );

      // Clear the input field
      messageController.clear();

      debugPrint('✅ Message sent successfully');
      return;
    } catch (e) {
      debugPrint('❗️ Error sending message: $e');
      return;
    } finally {
      if (mounted) {
        setState(() {
          isSendingMessage = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 62),
        child: MessengerAppbar(
          name: widget.name,
          photoUrl: widget.photoUrl ?? "",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Consumer<ChatProvider>(builder: (
            context,
            provider,
            child,
          ) {
            return Skeletonizer(
              enabled: provider.isFetching,
              enableSwitchAnimation: true,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: provider.isFetching
                          ? dummyMessages.length
                          : chatMessages.length,
                      itemBuilder: (context, index) {
                        final msg = provider.isFetching
                            ? dummyMessages[index]
                            : chatMessages[index];
                        return MessageCard(
                          message: msg.content ?? '',
                          isSentByMe: msg.fromSelf,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.sm,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: RoundedTextField(
                            hintText: context.tr('message...'),
                            fillColor: Colors.deepPurple.shade50,
                            textColor: Colors.black,
                            controller: messageController,
                            enabled: !isSendingMessage,
                          ),
                        ),
                        FittedBox(
                          child: isSendingMessage
                              ? Padding(
                                  padding: const EdgeInsets.all(AppSizes.sm),
                                  child: SizedBox(
                                    width: AppSizes.md,
                                    height: AppSizes.md,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        context.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                )
                              : IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: _sendMessage,
                                  icon: Icon(
                                    Iconsax.send_1,
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
