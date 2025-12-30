import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/controller/friend_controller.dart';
import 'package:skill_swap/model/user_model.dart';

final friendNotifier =
    AsyncNotifierProvider.autoDispose<FriendNotifier, List<UserModel>>(
  FriendNotifier.new,
);

class FriendNotifier extends AutoDisposeAsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() async {
    return [];
  }

  Future<void> fetch() async {
    state = const AsyncLoading();
    try {
      final response = await FriendController.instance.friends();
      final users = (response['users'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
