import 'dart:convert';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> registerUser({
    required String email,
    required String phoneNumber,
    required String username,
    required String password,
  }) async {
    const url = 'http://broadway.extramindtech.com/user/createuser/';

    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({
          "Email": email,
          "Phonenumber": phoneNumber,
          "Username": username,
          "Password": password,
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      return response.data;
    } on DioError catch (e) {
      throw e.response?.data['msg'] ?? 'Registration failed. Please try again.';
    }
  }

//   Future<Map<String, dynamic>> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     const url = 'http://broadway.extramindtech.com/user/login/';

//     try {
//       final response = await _dio.post(
//         url,
//         data: jsonEncode({
//           "Email": email,
//           "Password": password,
//         }),
//         options: Options(headers: {'Content-Type': 'application/json'}),
//       );

//       return response.data;
//     } on DioError catch (e) {
//       throw e.response?.data['msg'] ?? 'Login failed. Please try again.';
//     }
//   }
// }
Future<Map<String, dynamic>> loginUser({
  required String email,
  required String password,
}) async {
  const url = 'http://broadway.extramindtech.com/user/login/';

  try {
    final response = await _dio.post(
      url,
      data: jsonEncode({
        "Email": email,
        "Password": password,
      }),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );


    final token = response.data['token']; 
    print('Login Token: $token');

    return response.data;
  } on DioError catch (e) {
    throw e.response?.data['msg'] ?? 'Login failed. Please try again.';
  }
}

}
