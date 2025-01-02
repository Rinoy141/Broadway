import 'package:broadway/Job/model/job_model.dart';
import 'package:broadway/common/sharedpref/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class JobProvider with ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  List<Job> _jobResults = [];
  Map<String, dynamic> _profileData = {};

  bool get isLoading => _isLoading;
  String get error => _error;
  List<Job> get jobResults => _jobResults;
  Map<String, dynamic> get profileData => _profileData;

  // Search Jobs
  Future<void> searchJobs(String searchQuery) async {
    _setLoading(true);
    _clearError();

    try {
      const String url = 'https://broadway.icgedu.com/job/searchjobs/';

      final token = await SharedPreferencesHelper.getAuthToken();
      if (token == null || token.isEmpty) {
        _setError('Authorization token is missing.');
        return;
      }

      final response = await Dio().post(
        url,
        data: {"Search": searchQuery},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          _jobResults = responseData.map((job) => Job.fromJson(job)).toList();
        } else if (responseData['msg'] == "No Jobs in this title. Stay Updated.") {
          _jobResults = [];
        } else {
          _setError('Unexpected response format');
        }
      } else {
        _setError('Failed to fetch jobs. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _setError('Unexpected error occurred: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Create Profile
  Future<void> createProfile({
    required String userName,
    String? email,
    String? phoneNumber,
    required String title,
    required String qualification,
    required String description,
    String? userPhotoPath, 
  }) async {
    _setLoading(true);
    _clearError();

    try {
      const String url = 'https://broadway.icgedu.com/job/createprofile/';

      final token = await SharedPreferencesHelper.getAuthToken();
      if (token == null || token.isEmpty) {
        _setError('Authorization token is missing.');
        return;
      }

      FormData formData = FormData.fromMap({
        'User_Name': userName,
        'Email': email,
        'Phonenumber': phoneNumber,
        'Title': title,
        'Qualification': qualification,
        'Description': description,
        if (userPhotoPath != null) 'User_Photo': await MultipartFile.fromFile(userPhotoPath),
      });

      final response = await Dio().post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        _profileData = responseData;
      } else {
        _setError('Failed to create profile. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _setError('Unexpected error occurred: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Show Profile
  Future<void> showProfile() async {
    _setLoading(true);
    _clearError();

    try {
      const String url = 'https://broadway.icgedu.com/job/showprofile/';

      final token = await SharedPreferencesHelper.getAuthToken();
      if (token == null || token.isEmpty) {
        _setError('Authorization token is missing.');
        return;
      }

      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          _profileData = responseData;
        } else {
          _setError('Profile unavailable!');
        }
      } else {
        _setError('Failed to fetch profile. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _setError('Unexpected error occurred: $e');
    } finally {
      _setLoading(false);
    }
  }

 
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  void _clearError() {
    _error = '';
  }


  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void _handleDioError(DioException e) {
    if (e.response != null && e.response!.data != null) {
      _setError(e.response!.data['msg'] ?? 'Error occurred');
    } else {
      _setError('Network error occurred');
    }
  }
}
