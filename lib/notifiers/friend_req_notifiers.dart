import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/controller/friend_controller.dart';
import 'package:skill_swap/model/user_model.dart';

final requestsProvider =
    AsyncNotifierProvider.autoDispose<RequestsNotifier, List<UserModel>>(
  RequestsNotifier.new,
);

class RequestsNotifier extends AutoDisposeAsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() async {
    return [];
  }

  Future<void> fetch() async {
    state = const AsyncLoading();
    try {
      final response = await FriendController.instance.getRequests();

      final users = (response['friendRequests'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> respondRequest(
      {required String userId, required String action}) async {
    try {
      await FriendController.instance
          .respondRequest(userId: userId, action: action);
      removeById(userId);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  void removeById(String id) {
    state = state.whenData(
      (users) => users.where((user) => user.id != id).toList(),
    );
  }
}
