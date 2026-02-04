import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
// import 'package:skeletonizer/skeletonizer.dart';
import 'package:skill_swap/common/reusables/search_text.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/user_model.dart';
import 'package:skill_swap/providers/friends_provider.dart';
import 'package:skill_swap/screens/Main/Messenger/messenger.dart';
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
    Future.microtask(_loadAll);
  }

  Future<void> _loadAll() async {
    final provider = context.read<FriendProvider>();
    await provider.fetchAll();
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
    return _dataState(
      context.read<FriendProvider>().sentRequests,
      Icon(
        Iconsax.profile_delete,
        color: Colors.red.shade900,
      ),
      false,
    );
  }

  Widget _requestsWidget() {
    return _dataState(
      context.read<FriendProvider>().requests,
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.red.shade900,
            size: AppSizes.md,
          ),
        ],
      ),
      true,
    );
  }

  Widget _contactsWidget() {
    return _dataState(
      context.read<FriendProvider>().friends,
      Icon(
        Iconsax.message_favorite4,
        color: Colors.red.shade900,
      ),
      false,
    );
  }

  Widget _dataState(List<UserModel> users, Widget trailing, bool? isRequest) {
    if (users.isEmpty) {
      return Center(
        child: Text(
          context.tr('No Users Found'),
          style: context.textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      padding: const EdgeInsets.all(AppSizes.xs),
      itemBuilder: (context, index) {
        return FriendsTile(
          isRequest: isRequest,
          user: users[index],
          trailing: trailing,
        );
      },
    );
  }

  // Widget _errorState(Object e) {
  //   return Center(
  //     child: Text(
  //       e.toString(),
  //       style: context.textTheme.titleMedium?.copyWith(
  //         color: Colors.red.shade900,
  //       ),
  //     ),
  //   );
  // }

  // Widget _loadingSkeleton() {
  //   return Skeletonizer(
  //     enabled: true,
  //     child: ListView.builder(
  //       itemCount: 10, // fake count
  //       padding: const EdgeInsets.all(AppSizes.xs),
  //       itemBuilder: (_, __) => const FriendsTile(
  //         trailing: SizedBox.shrink(),
  //         user: UserModel(
  //           id: '1234642453',
  //           name: 'Loading',
  //           description: 'This is a loading description',
  //           profileUrl: 'This is a loading description',
  //           skills: ["Flutter", "Dart"],
  //           email: 'test@gmail.com',
  //           isPremiumUser: false,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class FriendsTile extends StatelessWidget {
  final Widget trailing;
  final UserModel user;
  final bool? isRequest;
  const FriendsTile({
    required this.user,
    super.key,
    required this.trailing,
    this.isRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Row(
        children: [
          MessengerProfile(
            radius: 28,
            photoUrl: user.profileUrl,
          ),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ViewProfile(
                //       user: user,
                //       isRequest: isRequest ?? false,
                //     ),
                //   ),
                // );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    user.name,
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  AutoSizeText(
                    user.description,
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
