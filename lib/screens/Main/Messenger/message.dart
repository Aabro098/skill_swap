import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/common/reusables/message_card.dart';
import 'package:skill_swap/common/reusables/search_text.dart';
import 'package:skill_swap/common/widgets/messenger_appbar.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/chat_message.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.name, required this.photoUrl});
  final String name;
  final String photoUrl;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List<ChatMessage> messages = [
    ChatMessage(
      text: "Hey! How's it going?",
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    ChatMessage(
      text: "Hi! I'm good, thanks. How about you?",
      isMe: true,
      time: DateTime.now().subtract(const Duration(minutes: 13)),
    ),
    ChatMessage(
      text: "Doing well! Did you finish the project?",
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    ChatMessage(
      text: "Yes, I sent it over this morning.",
      isMe: true,
      time: DateTime.now().subtract(const Duration(minutes: 7)),
    ),
    ChatMessage(
      text: "Great! Thanks for the update.",
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 62),
        child: MessengerAppbar(name: widget.name, photoUrl: widget.photoUrl),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return MessageCard(
                    message: msg.text,
                    isSentByMe: msg.isMe,
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
                      hintText: "Message...",
                      fillColor: Colors.deepPurple.shade50,
                      textColor: Colors.black,
                    ),
                  ),
                  FittedBox(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: Icon(Iconsax.send_1,
                          color: context.colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
