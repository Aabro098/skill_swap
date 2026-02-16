import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/common/reusables/search_text.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/chat_list_model.dart';
import 'package:skill_swap/providers/chat_provider.dart';
import 'package:skill_swap/screens/Main/Messenger/message.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({super.key});

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().fetchChatList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SafeArea(
          child: Consumer<ChatProvider>(builder: (
            context,
            provider,
            child,
          ) {
            return Skeletonizer(
              enabled: provider.isLoading,
              enableSwitchAnimation: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      MenuWidget(),
                      Expanded(
                          child: RoundedTextField(
                        prefixIcon: Iconsax.search_favorite,
                      )),
                    ],
                  ),
                  // const SizedBox(height: AppSizes.md),
                  // AutoSizeText(
                  //   context.tr('recent_interactions'),
                  //   style: context.textTheme.titleLarge?.copyWith(
                  //       fontWeight: FontWeight.w700, color: Colors.white),
                  // ),
                  // const SizedBox(height: AppSizes.md),
                  // SizedBox(
                  //   height: 68,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: 10,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return const Padding(
                  //         padding: EdgeInsets.only(right: 2.0),
                  //         child: MessengerProfile(
                  //           radius: 32,
                  //           photoUrl:
                  //               "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=687&q=80",
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: AppSizes.md),
                  AutoSizeText(
                    context.tr('messages'),
                    style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: AppSizes.md),
                  if (provider.chatList.isEmpty && !provider.isLoading)
                    Center(
                      child: Text(
                        "No Messages Found",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.isLoading
                          ? dummyChats.length
                          : provider.chatList.length,
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final message = provider.isLoading
                            ? dummyChats[index]
                            : provider.chatList[index];
                        return MessengerTile(message: message);
                      },
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

class MessengerTile extends StatelessWidget {
  const MessengerTile({
    super.key,
    required this.message,
  });

  final ChatModel message;

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
                id: message.user.id,
                name: message.user.name,
                photoUrl: message.user.profileUrl,
              ),
            ),
          );
        },
        child: Row(
          children: [
            MessengerProfile(
              radius: 28,
              photoUrl: message.user.profileUrl,
            ),
            const SizedBox(width: AppSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    message.user.name,
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  AutoSizeText(
                    message.lastMessage.content ?? "",
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.onSurface),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.md),
            Text(
              message.lastMessage.timestamp != null
                  ? TimeOfDay.fromDateTime(message.lastMessage.timestamp!)
                      .format(context)
                  : "",
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color: context.colorScheme.onPrimary,
              ),
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
        backgroundImage: const AssetImage(AppImages.fallback),
        foregroundImage: NetworkImage(photoUrl),
        onForegroundImageError: (_, __) {},
      ),
    );
  }
}
