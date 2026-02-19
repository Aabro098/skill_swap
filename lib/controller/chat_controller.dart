import 'package:dio/dio.dart';
import 'package:skill_swap/model/base_model.dart';
import 'package:skill_swap/model/chat_list_model.dart';
import 'package:skill_swap/services/dio_client.dart';
import 'package:skill_swap/utils/constants/api_constants.dart';

class ChatController {
  ChatController._();

  /// Singleton instance for the ChatController.
  static final ChatController _instance = ChatController._();

  /// Provides access to the singleton instance.
  static ChatController get instance => _instance;

  Future<List<ChatModel>> getChatList() async {
    final dio = await DioClient.initClient();

    try {
      final response = await dio.get<Map<String, dynamic>>(
        UrlStrings.getChatList,
      );
      final data = response.data as Map<String, dynamic>;
      final responseData = ChatListResponse(
        chats: data['chats'] != null
            ? BaseModel.parseList(
                data['chats'],
                (e) => ChatModel.fromJson(e as Map<String, dynamic>),
              )!
            : [],
      );
      return responseData.chats;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MessageModel>> getChatHistory({required String id}) async {
    final dio = await DioClient.initClient();

    try {
      final response = await dio.get<Map<String, dynamic>>(
        "${UrlStrings.getChatList}/$id",
      );
      final data = response.data as Map<String, dynamic>;
      final responseData = MessageListResponse(
        messages: data['messages'] != null
            ? BaseModel.parseList(
                data['messages'],
                (e) => MessageModel.fromJson(e as Map<String, dynamic>),
              )!
            : [],
      );
      return responseData.messages;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
