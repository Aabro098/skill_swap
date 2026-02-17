import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/controller/friend_controller.dart';
import 'package:skill_swap/model/user_model.dart';

class FriendProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<UserModel> _friends = [];
  List<UserModel> get friends => _friends;

  List<UserModel> _requests = [];
  List<UserModel> get requests => _requests;

  List<UserModel> _sentRequests = [];
  List<UserModel> get sentRequests => _sentRequests;

  Future<void> fetchAll() async {
    _isLoading = true;
    await Future.wait([
      fetchFriends(),
      fetchRequests(),
      fetchSentRequests(),
    ]);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFriends() async {
    try {
      final response = await FriendController.instance.friends();
      final usersRaw = response['users'];
      final users = (usersRaw is List)
          ? usersRaw.map((e) => UserModel.fromJson(e)).toList()
          : <UserModel>[];
      _friends = users;
      notifyListeners();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchRequests() async {
    try {
      final response = await FriendController.instance.getRequests();
      final usersRaw = response['friendRequests'];
      final users = (usersRaw is List)
          ? usersRaw.map((e) => UserModel.fromJson(e)).toList()
          : <UserModel>[];
      _requests = users;
      notifyListeners();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchSentRequests() async {
    try {
      final response = await FriendController.instance.sentRequests();
      final usersRaw = response['sentRequests'];
      final users = (usersRaw is List)
          ? usersRaw.map((e) => UserModel.fromJson(e)).toList()
          : <UserModel>[];
      _sentRequests = users;
      notifyListeners();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> respondRequest({required String userId}) async {
    try {
      await FriendController.instance.respondRequest(userId: userId);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
