import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providerss/app_provider.dart';

class SetProfilePage extends StatefulWidget {
  @override
  SetProfilePageState createState() => SetProfilePageState();
}

class SetProfilePageState extends State<SetProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController addressController;
  late TextEditingController countryController;
  late TextEditingController districtController;
  late TextEditingController placeController;
  late TextEditingController genderController;

  File? _profileImage;
  File? _idImage;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
    countryController = TextEditingController();
    districtController = TextEditingController();
    placeController = TextEditingController();
    genderController = TextEditingController();

    final provider = Provider.of<MainProvider>(context, listen: false);
    addressController.text = provider.emailController.text;
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

  Future<void> _pickImage(bool isProfilePic) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isProfilePic) {
          _profileImage = File(pickedFile.path);
        } else {
          _idImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Set Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<MainProvider>(
            builder: (context, loginProvider, _) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      GestureDetector(
                        onTap: () => _pickImage(true),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                          child: _profileImage == null
                              ? Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.grey[800]
                          )
                              : null,
                        ),

                      ),
                      const SizedBox(height: 16.0),
                      Text('Profile Picture'),
                      const SizedBox(height: 16.0),


                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Address is required' : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: countryController,
                        decoration: const InputDecoration(
                          labelText: 'Country',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Country is required' : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: districtController,
                        decoration: const InputDecoration(
                          labelText: 'District',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'District is required' : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: placeController,
                        decoration: const InputDecoration(
                          labelText: 'Place',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Place is required' : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: genderController,
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Gender is required' : null,
                      ),
                      const SizedBox(height: 16.0),

                      // ID Image Upload
                      ElevatedButton(
                        onPressed: () => _pickImage(false),
                        child: Text(_idImage == null
                            ? 'Upload ID Image'
                            : 'Change ID Image'),
                      ),
                      if (_idImage != null)
                        Image.file(
                            _idImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover
                        ),
                      const SizedBox(height: 24.0),

                      MaterialButton(minWidth: 300,
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              _profileImage != null &&
                              _idImage != null) {

                            await loginProvider.handleAddressUpdate(
                              context: context,
                              country: countryController.text.trim(),
                              address: addressController.text.trim(),
                              district: districtController.text.trim(),
                              place: placeController.text.trim(),
                              gender: genderController.text.trim(),
                              profilePic: _profileImage,
                              idImage: _idImage,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please upload both Profile Picture and ID Image'),
                              ),
                            );
                          }
                        },
                        color: const Color(0xff004CFF),
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: const Text('Submit your profile', style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}