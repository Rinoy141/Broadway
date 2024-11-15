import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../login/forgot_password.dart';
import '../login/loginpage.dart';


// NotificationSettings model
class NotificationSettings extends ChangeNotifier {
  final Map<String, bool> _settings = {
    'General Notification': true,
    'Sound': false,
    'Vibrate': true,
    'App updates': false,
    'Bill Reminder': true,
    'Promotion': true,
    'Discount Available': false,
    'Payment Request': false,
    'New Service Available': false,
    'New Tips Available': true,
  };

  bool getSetting(String key) => _settings[key] ?? false;

  void toggleSetting(String key) {
    _settings[key] = !(_settings[key] ?? false);
    notifyListeners();
  }
}




 /// REGISTRATION
class RegistrationProvider with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String phoneNumber = '';
  bool isLoading = false;
  String? errorMessage;

  Future<void> register(BuildContext context) async {
    if (!validateInputs()) return;

    try {
      setLoading(true);

      final requestBody = {
        'Email': emailController.text.trim(),
        'Phonenumber': phoneNumber.trim(),
        'Username': usernameController.text.trim(),
        'Password': passwordController.text,
      };

      print("Sending registration request: $requestBody");

      final response = await http.post(
        Uri.parse('http://broadway.extramindtech.com/user/createuser/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print("Response received: ${response.statusCode} - ${response.body}");

      if (!context.mounted) return;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['msg'] == 'Rgisteration success') {
          // Clear any previous error messages
          errorMessage = null;
          notifyListeners();

          // Navigate to login page
          await navigateToLogin(context);
          return;
        }
      }

      // Handle error cases
      final responseData = jsonDecode(response.body);
      setError(responseData['msg'] ?? 'Registration failed. Please try again.');

    } catch (e) {
      setError('Connection error. Please check your internet connection.');
      print("Registration error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> navigateToLogin(BuildContext context) async {
    // Ensure we're not in a loading state before navigation
    setLoading(false);

    if (!context.mounted) return;

    // Navigate immediately without delay
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  bool validateInputs() {
    if (usernameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        phoneNumber.trim().isEmpty) {
      setError('All fields are required');
      return false;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text.trim())) {
      setError('Please enter a valid email address');
      return false;
    }

    return true;
  }

  void updatePhoneNumber(String phone) {
    phoneNumber = phone;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}



///LOGIN
class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const String USER_ID_KEY = 'user_id';
  static const String USER_EMAIL_KEY = 'user_email';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    print('Attempting login...');

    final url = Uri.parse('http://broadway.extramindtech.com/user/login/');
    final body = {
      'Email': emailController.text,
      'Password': passwordController.text,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      final data = jsonDecode(response.body);

      print('Login API response: $data');

      if (response.statusCode == 200) {
        if (data['msg'] == 'Login Success') {
          print('Login successful');
          await handleLoginSuccess(data['id'], emailController.text);
          return true;
        } else {
          showErrorDialog(context, data['msg']);
          print('Login failed: ${data['msg']}');
          return false;
        }
      } else {
        showErrorDialog(context, 'An error occurred. Please try again later.');
        print('API request failed: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      showErrorDialog(context, 'An error occurred. Please try again later.');
      print('Exception occurred during login: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> handleLoginSuccess(int userId, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(USER_ID_KEY, userId);
    await prefs.setString(USER_EMAIL_KEY, email);
    print('Saved user ID: $userId and email: $email');
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(USER_ID_KEY);
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_EMAIL_KEY);
  }

  Future<bool> isLoggedIn() async {
    final userId = await getUserId();
    return userId != null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(USER_ID_KEY);
    await prefs.remove(USER_EMAIL_KEY);
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

///FORGOT PASSWORD
class ForgotPasswordProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> forgotPassword(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    print('Attempting to send password reset email...');

    final url = Uri.parse('http://broadway.extramindtech.com/user/forgot-password/');
    final body = {
      'Email': emailController.text,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      // Check if the response content type is JSON before parsing
      if (response.headers['content-type']?.contains('application/json') == true) {
        final data = jsonDecode(response.body);
        print('Forgot password API response: $data');

        if (response.statusCode == 200) {
          print('Status 200: Success - Password reset email sent.');
          if (data['msg'] == 'Password reset email sent') {
            showSuccessDialog(context, 'Password reset email has been sent to your email address.');
            return true;
          } else {
            showErrorDialog(context, data['msg'] ?? 'An error occurred');
            return false;
          }
        } else if (response.statusCode == 400) {
          print('Status 400: Bad Request - Possibly invalid email format or missing data.');
          showErrorDialog(context, 'Invalid email format or missing data. Please check your input.');
          return false;
        } else if (response.statusCode == 404) {
          print('Status 404: Not Found - The endpoint does not exist.');
          showErrorDialog(context, 'Unable to reach the server. Please try again later.');
          return false;
        } else if (response.statusCode == 500) {
          print('Status 500: Internal Server Error - Server-side issue.');
          showErrorDialog(context, 'Server is currently unavailable. Please try again later.');
          return false;
        } else {
          print('Unexpected status code: ${response.statusCode} - ${response.body}');
          showErrorDialog(context, 'An error occurred. Please try again later.');
          return false;
        }
      } else {
        print('Received non-JSON response: ${response.body}');
        showErrorDialog(context, 'Unexpected response from server. Please try again later.');
        return false;
      }
    } catch (e) {
      print('Exception occurred during password reset: $e');
      showErrorDialog(context, 'An error occurred. Please try again later.');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PasswordRecoveryScreen(),
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

///EDIT PRFILE


class EditProfileProvider extends ChangeNotifier {
  static const baseUrl = 'http://broadway.extramindtech.com';
  static const String USER_ID_KEY = 'user_id'; // Add this constant

  String _address = '';
  String _country = '';
  String _district = '';
  String _place = '';
  String _idImage = '';
  String _gender = '';
  String _profilePic = '';
  String _token = '';

  // Getters
  String get address => _address;
  String get country => _country;
  String get district => _district;
  String get place => _place;
  String get idImage => _idImage;
  String get gender => _gender;
  String get profilePic => _profilePic;

  // Initialize provider with user data
  Future<void> initializeProvider() async {
    await loadUserToken();
  }

  // Load user token from SharedPreferences
  Future<void> loadUserToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(USER_ID_KEY);
      if (userId != null) {
        _token = userId.toString();
        print('DEBUG: Loaded user token: $_token');
      } else {
        print('ERROR: No user ID found in SharedPreferences');
      }
      notifyListeners();
    } catch (e) {
      print('ERROR loading user token: $e');
    }
  }

  // Setters
  set address(String value) {
    print('DEBUG: Setting address to: $value');
    _address = value;
    notifyListeners();
  }

  set country(String value) {
    print('DEBUG: Setting country to: $value');
    _country = value;
    notifyListeners();
  }

  set district(String value) {
    print('DEBUG: Setting district to: $value');
    _district = value;
    notifyListeners();
  }

  set place(String value) {
    print('DEBUG: Setting place to: $value');
    _place = value;
    notifyListeners();
  }

  set gender(String value) {
    print('DEBUG: Setting gender to: $value');
    _gender = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> updateUserData() async {
    try {
      if (_token.isEmpty) {
        await loadUserToken();
        if (_token.isEmpty) {
          return {
            'success': false,
            'message': 'User not authenticated. Please login again.'
          };
        }
      }

      print('DEBUG: Starting updateUserData');
      print('DEBUG: Current values:');
      print('Address: $_address');
      print('Country: $_country');
      print('District: $_district');
      print('Place: $_place');
      print('Gender: $_gender');
      print('Token: $_token');

      final url = Uri.parse('$baseUrl/user/addaddress/');
      print('DEBUG: API URL: $url');

      final body = {
        'Address': _address,
        'Country': _country,
        'District': _district,
        'Place': _place,
        'Gender': _gender,
      };
      print('DEBUG: Request body: $body');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      print('DEBUG: Request headers: $headers');

      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      print('DEBUG: Response status code: ${response.statusCode}');
      print('DEBUG: Response body: ${response.body}');

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      print('DEBUG: Decoded response data: $data');

      if (response.statusCode == 200) {
        if (data['msg'] != 'User not authenticated') {
          print('DEBUG: Update successful');
          return {
            'success': true,
            'message': data['msg'] ?? 'Profile updated successfully'
          };
        } else {
          print('DEBUG: Update failed - User not authenticated');
          return {
            'success': false,
            'message': 'User not authenticated. Please login again.'
          };
        }
      } else {
        print('DEBUG: API request failed with status ${response.statusCode}');
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      print('ERROR in updateUserData: $e');
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}'
      };
    }
  }
}


