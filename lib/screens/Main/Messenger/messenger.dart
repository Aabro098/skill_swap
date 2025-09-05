import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/common/reusables/search_text.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/message_screen_model.dart';
import 'package:skill_swap/screens/Main/Messenger/message.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({super.key});

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  final List<MessageScreenModel> demoMessages = [
    MessageScreenModel(
      name: "Alice Johnson",
      photoUrl:
          "https://images.unsplash.com/photo-1502685104226-ee32379fefbe?auto=format&fit=crop&w=687&q=80",
      lastMessage: "Hey! Are we still on for tomorrow?",
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    MessageScreenModel(
      name: "Michael Chen",
      photoUrl:
          "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=687&q=80",
      lastMessage: "Sure, I’ll send the documents tonight.",
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    MessageScreenModel(
      name: "Sofia Martinez",
      photoUrl:
          "https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=687&q=80",
      lastMessage: "That was hilarious 😂",
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    MessageScreenModel(
      name: "David Kim",
      photoUrl:
          "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=687&q=80",
      lastMessage: "I’ll call you later tonight.",
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
    MessageScreenModel(
      name: "Emma Williams",
      photoUrl:
          "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=687&q=80",
      lastMessage: "Loved the photos you sent!",
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
    ),
    MessageScreenModel(
      name: "Chris Evans",
      photoUrl:
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=687&q=80",
      lastMessage: "Let's meet at the café around 4?",
      lastMessageTime: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          gradient: context.gradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    MenuWidget(),
                    SizedBox(
                      width: AppSizes.sm,
                    ),
                    Expanded(
                        child: RoundedTextField(
                      prefixIcon: Iconsax.search_favorite,
                    )),
                  ],
                ),
                const SizedBox(height: AppSizes.md),
                AutoSizeText(
                  "Recent Interactions",
                  style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: AppSizes.md),
                SizedBox(
                  height: 68,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: MessengerProfile(
                          radius: 32,
                          photoUrl:
                              "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=687&q=80",
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.md),
                AutoSizeText(
                  "Messages",
                  style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: AppSizes.md),
                Expanded(
                  child: ListView.builder(
                    itemCount: demoMessages.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext context, int index) {
                      final message = demoMessages[index];
                      return MessengerTile(message: message);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessengerTile extends StatelessWidget {
  const MessengerTile({
    super.key,
    required this.message,
  });

  final MessageScreenModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessageScreen(
                name: message.name,
                photoUrl: message.photoUrl,
              ),
            ),
          );
        },
        child: Row(
          children: [
            MessengerProfile(
              radius: 28,
              photoUrl: message.photoUrl,
            ),
            const SizedBox(width: AppSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    message.name,
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  AutoSizeText(
                    message.lastMessage,
                    style: context.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.md),
            Text(
              "2:30 AM",
              style: context.textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class MessengerProfile extends StatelessWidget {
  const MessengerProfile({
    required this.photoUrl,
    required this.radius,
    super.key,
  });
  final String photoUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.purple,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(photoUrl),
      ),
    );
  }
}
