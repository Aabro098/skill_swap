import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/controller/friend_controller.dart';
import 'package:skill_swap/model/user_model.dart';

final sentRequestsProvider =
    AsyncNotifierProvider.autoDispose<SentRequestsNotifier, List<UserModel>>(
  SentRequestsNotifier.new,
);

class SentRequestsNotifier extends AutoDisposeAsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() async {
    return [];
  }

  Future<void> fetch() async {
    state = const AsyncLoading();
    try {
      final response = await FriendController.instance.sentRequests();
      final users = (response['sentRequests'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
