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
  bool isSendingMessage = false;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    scrollController = ScrollController();
    setMessages();
    _setupNewMessageListener();
  }

  void _setupNewMessageListener() {
    // Register callback in ChatProvider to receive new messages
    context.read<ChatProvider>().onNewMessage((MessageModel message) {
      if (mounted) {
        setState(() {
          chatMessages.add(message);
        });
        // Scroll to bottom after new message
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollToBottom();
        });
      }
    });
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
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
      Future.delayed(const Duration(milliseconds: 100), () {
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
