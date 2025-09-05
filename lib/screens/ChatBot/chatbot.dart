import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skill_swap/common/reusables/message_card.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/common/widgets/message_box.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/screens/Main/Messenger/message_sample.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  bool _isUnlocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MenuWidget(),
        centerTitle: true,
        title: _isUnlocked
            ? AutoSizeText(
                "Skill Bot",
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              )
            : null,
      ),
      body: _isUnlocked
          ? const UnlockedChatbot()
          : LockedChatbot(
              onUnlock: () {
                if (mounted) {
                  setState(() {
                    _isUnlocked = true;
                  });
                }
              },
            ),
    );
  }
}

class LockedChatbot extends StatelessWidget {
  const LockedChatbot({
    super.key,
    required this.onUnlock,
  });

  final VoidCallback onUnlock;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSizes.lg),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Meet\n",
                    style: context.textTheme.headlineLarge,
                  ),
                  TextSpan(
                    text: "Skill Bot !",
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Lottie.asset(
              AppImages.robot,
              height: context.screenHeight * 0.4,
              width: context.screenWidth * 0.5,
              fit: BoxFit.cover,
            ),
          ),
          AutoSizeText(
            "Looks like you haven't unlocked the chatbot feature yet. Unlock it to get instant help and support from our AI-powered chatbot.",
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.lg),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36.0),
              child: SizedBox(
                width: 196,
                child: ElevatedButton(
                    onPressed: onUnlock, child: const Text("Unlock Chatbot")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UnlockedChatbot extends StatefulWidget {
  const UnlockedChatbot({super.key});

  @override
  State<UnlockedChatbot> createState() => _UnlockedChatbotState();
}

class _UnlockedChatbotState extends State<UnlockedChatbot> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.asset(
                        AppImages.robotHello,
                        height: context.screenHeight * 0.35,
                        width: context.screenWidth * 0.5,
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: AutoSizeText(
                          "No messages yet. Start the conversation!",
                          style: context.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
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
            hint: "Ask a question...",
          ),
        ],
      ),
    );
  }
}
