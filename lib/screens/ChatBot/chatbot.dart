import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/common/reusables/message_card.dart';
import 'package:skill_swap/common/reusables/search_text.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/providers/chatbot_provider.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  // bool _isUnlocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MenuWidget(),
        centerTitle: true,
        title: AutoSizeText(
          context.tr('skill_bot'),
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
        ),
      ),
      body: const UnlockedChatbot(),
      // body: _isUnlocked
      //     ? const UnlockedChatbot()
      //     : LockedChatbot(
      //         onUnlock: () {
      //           if (mounted) {
      //             setState(() {
      //               _isUnlocked = true;
      //             });
      //           }
      //         },
      //       ),
    );
  }
}

// class LockedChatbot extends StatelessWidget {
//   const LockedChatbot({
//     super.key,
//     required this.onUnlock,
//   });

//   final VoidCallback onUnlock;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(AppSizes.padding),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: AppSizes.lg),
//             child: RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: "${context.tr('meet')}\n",
//                     style: context.textTheme.headlineLarge,
//                   ),
//                   TextSpan(
//                     text: context.tr('skill_bot!'),
//                     style: context.textTheme.headlineLarge?.copyWith(
//                       color: context.colorScheme.primary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: Lottie.asset(
//               AppImages.robot,
//               height: context.screenHeight * 0.4,
//               width: context.screenWidth * 0.5,
//               fit: BoxFit.cover,
//             ),
//           ),
//           AutoSizeText(
//             context.tr('locked_message'),
//             style: context.textTheme.bodyMedium,
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: AppSizes.lg),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 36.0),
//               child: SizedBox(
//                 width: 196,
//                 child: ElevatedButton(
//                     onPressed: onUnlock,
//                     child: Text(context.tr('unlock_message'))),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class UnlockedChatbot extends StatefulWidget {
  const UnlockedChatbot({super.key});

  @override
  State<UnlockedChatbot> createState() => _UnlockedChatbotState();
}

class _UnlockedChatbotState extends State<UnlockedChatbot> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Consumer<ChatbotProvider>(
          builder: (context, chatbotProvider, _) {
            final messages = chatbotProvider.messages;
            final isLoading =
                chatbotProvider.isLoading; // Add this to your provider

            // Auto-scroll when messages change or loading state changes
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (messages.isNotEmpty || isLoading) {
                _scrollToBottom();
              }
            });

            return Column(
              children: [
                Expanded(
                  child: messages.isEmpty && !isLoading
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
                                context.tr('no_messages'),
                                style: context.textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: messages.length + (isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == messages.length) {
                              return const MessageCard(
                                message: '',
                                isSentByMe: false,
                                isLoading: true,
                              );
                            }

                            final msg = messages[index];
                            return MessageCard(
                              message: msg.message,
                              isSentByMe: msg.isSentByMe,
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
                          hintText: context.tr('ask_bot'),
                          fillColor: Colors.deepPurple.shade50,
                          textColor: Colors.black,
                          controller: _controller,
                          enabled: isLoading ? false : true,
                        ),
                      ),
                      FittedBox(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  final query = _controller.text.trim();
                                  if (query.isEmpty) return;
                                  _controller.clear();
                                  await chatbotProvider.getMessages(
                                    query: query,
                                  );
                                },
                          icon: Icon(
                            Iconsax.send_1,
                            color: isLoading
                                ? Colors.grey
                                : context.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
