import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/common/reusables/search_text.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/screens/Main/Messenger/messenger.dart';
import 'package:skill_swap/screens/Profile/profile.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              const SizedBox(height: AppSizes.sm),
              // Tab Bar
              Center(
                child: TabBar(
                  controller: _tabController,
                  tabAlignment: TabAlignment.center,
                  labelColor: context.colorScheme.primary,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: context.colorScheme.primary,
                  dividerColor: Colors.transparent,
                  dividerHeight: 0,
                  labelStyle: context.textTheme.titleSmall,
                  tabs: [
                    Tab(text: context.tr('contacts')),
                    Tab(text: context.tr('requests')),
                    Tab(text: context.tr('requested')),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.md),
              // Tab Bar View
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Contacts Tab
                    _contactsWidget(),
                    // Requests Tab
                    _requestsWidget(),
                    // Requested Tab
                    _requestedWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _requestedWidget() {
    return ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      padding: const EdgeInsets.all(AppSizes.xs),
      itemBuilder: (context, index) {
        return FriendsTile(
          trailing: Icon(
            Iconsax.profile_delete,
            color: Colors.red.shade900,
          ),
        );
      },
    );
  }

  Widget _requestsWidget() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      padding: const EdgeInsets.all(AppSizes.xs),
      itemBuilder: (context, index) {
        return FriendsTile(
            trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: const Icon(
                Iconsax.tick_circle,
                color: Colors.green,
                size: 24,
              ),
              onTap: () {},
            ),
            const SizedBox(width: AppSizes.sm),
            GestureDetector(
              child: Icon(
                Iconsax.close_circle,
                color: Colors.red.shade900,
                size: 24,
              ),
              onTap: () {},
            ),
          ],
        ));
      },
    );
  }

  Widget _contactsWidget() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(AppSizes.xs),
      itemCount: 12,
      itemBuilder: (context, index) {
        return const FriendsTile(
          trailing: Icon(Iconsax.message_favorite4),
        );
      },
    );
  }
}

class FriendsTile extends StatelessWidget {
  final Widget trailing;
  const FriendsTile({
    super.key,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Row(
        children: [
          const MessengerProfile(
            radius: 28,
            photoUrl:
                "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=687&q=80",
          ),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(isView: true),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "Arbin Shrestha",
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  AutoSizeText(
                    "Flutter developer and keen to meet you.",
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.onSurface),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSizes.md),
          trailing,
        ],
      ),
    );
  }
}
