import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../providerss/app_provider.dart';
import '../restaurant_model.dart';

class ProfileViewProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isEditing = false;
  bool _isInitialized = false;

  File? _pickedProfilePic;
  File? _pickedIdImage;
  String? _selectedGender;

  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _addressController;
  TextEditingController? _countryController;
  TextEditingController? _districtController;
  TextEditingController? _placeController;

  // Getters
  bool get isLoading => _isLoading;
  bool get isEditing => _isEditing;
  bool get isInitialized => _isInitialized;

  File? get pickedProfilePic => _pickedProfilePic;
  File? get pickedIdImage => _pickedIdImage;
  String? get selectedGender => _selectedGender;

  TextEditingController? get nameController => _nameController;
  TextEditingController? get emailController => _emailController;
  TextEditingController? get phoneController => _phoneController;
  TextEditingController? get addressController => _addressController;
  TextEditingController? get countryController => _countryController;
  TextEditingController? get districtController => _districtController;
  TextEditingController? get placeController => _placeController;

  // Initialize controllers with profile data
  void initializeControllers(ProfileModel? profileData) {
    _nameController = TextEditingController(text: profileData?.username ?? '');
    _emailController = TextEditingController(text: profileData?.email ?? '');
    _phoneController = TextEditingController(text: profileData?.phoneNumber ?? '');
    _addressController = TextEditingController(text: profileData?.address ?? '');
    _countryController = TextEditingController(text: profileData?.country ?? '');
    _districtController = TextEditingController(text: profileData?.district ?? '');
    _placeController = TextEditingController(text: profileData?.place ?? '');
    _selectedGender = profileData?.gender;
    _isInitialized = true;
    notifyListeners();
  }

  // Pick profile picture
  Future<void> pickProfilePicture() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedProfilePic = File(pickedFile.path);
      notifyListeners();
    }
  }

  // Save profile
  Future<bool> saveProfile(MainProvider mainProvider, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    if (_nameController == null ||
        _emailController == null ||
        _phoneController == null ||
        _addressController == null ||
        _countryController == null ||
        _districtController == null ||
        _placeController == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile data not loaded')),
      );
      _isLoading = false;
      notifyListeners();
      return false;
    }

    final bool success = await mainProvider.updateUserProfile(
      address: _addressController!.text.trim(),
      country: _countryController!.text.trim(),
      district: _districtController!.text.trim(),
      place: _placeController!.text.trim(),
      gender: _selectedGender,
      profilePic: _pickedProfilePic,
      idImage: _pickedIdImage,
    );

    _isLoading = false;
    if (success) {
      _isEditing = false;
      _pickedProfilePic = null;
      _pickedIdImage = null;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }

    return success;
  }

  // Toggle editing mode
  void toggleEditMode() {
    _isEditing = !_isEditing;
    _pickedProfilePic = null;
    _pickedIdImage = null;
    notifyListeners();
  }

  // Dispose controllers
  void disposeControllers() {
    _nameController?.dispose();
    _emailController?.dispose();
    _phoneController?.dispose();
    _addressController?.dispose();
    _countryController?.dispose();
    _districtController?.dispose();
    _placeController?.dispose();
  }
}