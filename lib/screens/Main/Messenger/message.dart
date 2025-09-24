import 'package:flutter/material.dart';
import 'package:skill_swap/common/reusables/message_card.dart';
import 'package:skill_swap/common/widgets/message_box.dart';
import 'package:skill_swap/common/widgets/messenger_appbar.dart';
import 'package:skill_swap/screens/Main/Messenger/message_sample.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.name, required this.photoUrl});
  final String name;
  final String photoUrl;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
            const MessageBox(
              hint: "Message...",
            ),
          ],
        ),
      ),
    );
  }
}
