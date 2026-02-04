import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:skill_swap/controller/friend_controller.dart';
import 'package:skill_swap/model/user_model.dart';

class RecommendedProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<UserModel> _recommendedUsers = [];
  List<UserModel> get recommendedUsers => _recommendedUsers;

  Future<void> fetchRecommendedUsers() async {
    loading = true;
    try {
      final response = await FriendController.instance.getRecommendedUsers();

      final data = response['users'] as List<dynamic>;
      final users = data
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
      _recommendedUsers = users;
      notifyListeners();
      return;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

  Future<Map<String, dynamic>> sendRequest({required String id}) async {
    final response = await FriendController.instance.sendRequest(id: id);
    return response;
  }
}
