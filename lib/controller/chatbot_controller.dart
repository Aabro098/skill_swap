import 'package:dio/dio.dart';
import 'package:skill_swap/services/dio_client.dart';
import 'package:skill_swap/utils/constants/api_constants.dart';

class ChatbotController {
  ChatbotController._();

  /// Singleton instance for the ChatbotController.
  static final ChatbotController _instance = ChatbotController._();

  /// Provides access to the singleton instance.
  static ChatbotController get instance => _instance;

  Future<Map<String, dynamic>> getResponse({required String query}) async {
    final dio = await DioClient.initClient();
    dio.options.baseUrl = UrlStrings.chatbotBaseUrl;

    final formData = {
      'query': query,
    };

    try {
      final response = await dio.post<Map<String, dynamic>>(
        UrlStrings.chatbot,
        data: formData,
      );
      final data = response.data as Map<String, dynamic>;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
