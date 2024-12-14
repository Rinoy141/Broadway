import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupProvider extends ChangeNotifier {
  File? _profileImage;
  File? _idImage;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  // Getters for images
  File? get profileImage => _profileImage;
  File? get idImage => _idImage;

  // Method to pick image
  Future<void> pickImage(bool isProfilePic) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (isProfilePic) {
        _profileImage = File(pickedFile.path);
      } else {
        _idImage = File(pickedFile.path);
      }
      notifyListeners();
    }
  }

  // Method to clear images
  void clearImages() {
    _profileImage = null;
    _idImage = null;
    notifyListeners();
  }

  // Validate all form fields
  bool validateForm() {
    return addressController.text.trim().isNotEmpty &&
        countryController.text.trim().isNotEmpty &&
        districtController.text.trim().isNotEmpty &&
        placeController.text.trim().isNotEmpty &&
        genderController.text.trim().isNotEmpty &&
        _profileImage != null &&
        _idImage != null;
  }

  @override
  void dispose() {
    addressController.dispose();
    countryController.dispose();
    districtController.dispose();
    placeController.dispose();
    genderController.dispose();
    super.dispose();
  }
}