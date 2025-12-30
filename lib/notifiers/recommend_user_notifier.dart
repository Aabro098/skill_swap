import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/controller/friend_controller.dart';
import 'package:skill_swap/model/user_model.dart';

final AutoDisposeAsyncNotifierProvider<RecommendUserNotifier, List<UserModel>>
    recommendedUsersProvider =
    AsyncNotifierProvider.autoDispose<RecommendUserNotifier, List<UserModel>>(
  RecommendUserNotifier.new,
);

class RecommendUserNotifier extends AutoDisposeAsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() async {
    return [];
  }

  Future<List<UserModel>> fetchRecommendedUsers() async {
    state = const AsyncLoading();
    try {
      final response = await FriendController.instance.getRecommendedUsers();

      final data = response['users'] as List<dynamic>;
      final users = data
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();

      state = AsyncData([...users]);
      return state.value!;
    } on DioException catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> sendRequest({required String id}) async {
    final response = await FriendController.instance.sendRequest(id: id);
    removeById(id);
    return response;
  }

  void removeById(String id) {
    state = state.whenData(
      (users) => users.where((user) => user.id != id).toList(),
    );
  }
}
