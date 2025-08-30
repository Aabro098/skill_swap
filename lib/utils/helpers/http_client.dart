import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  HttpHelper._();
  //* Using http package as helper function

  static const String _baseUrl = 'http://example.com';

  static Future<Map<String, dynamic>> get(String endPoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endPoint'));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(
      String endPoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endPoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> put(String endPoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endPoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> delete(String endPoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endPoint'));
    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      //Success response
      return jsonDecode(response.body);
    } else {
      //Failure response
      throw Exception('Failed to fetch data from the server.');
    }
  }
}


//* Usage for hhtp client

// void fetchUsers() async {
//   try {
//     Map<String, dynamic> response = await HttpHelper.get("users");
//     print("Users: $response");
//   } catch (e) {
//     print("Error fetching users: $e");
//   }
// }

// void createUser() async {
//   try {
//     Map<String, dynamic> response = await HttpHelper.post("users", {
//       "name": "John Doe",
//       "email": "john@example.com",
//     });
//     print("User created: $response");
//   } catch (e) {
//     print("Error creating user: $e");
//   }
// }

// void updateUser() async {
//   try {
//     Map<String, dynamic> response = await HttpHelper.put("users/1", {
//       "name": "John Updated",
//     });
//     print("User updated: $response");
//   } catch (e) {
//     print("Error updating user: $e");
//   }
// }

// void deleteUser() async {
//   try {
//     Map<String, dynamic> response = await HttpHelper.delete("users/1");
//     print("User deleted: $response");
//   } catch (e) {
//     print("Error deleting user: $e");
//   }
// }