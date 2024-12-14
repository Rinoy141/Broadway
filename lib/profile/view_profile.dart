import 'dart:io';
import 'package:broadway/profile/set_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../food_app/restaurant_model.dart';
import '../providerss/app_provider.dart';

class ProfileViewPage extends StatefulWidget {
  @override
  _ProfileViewPageState createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  bool _isLoading = false;

  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _addressController;
  TextEditingController? _countryController;
  TextEditingController? _districtController;
  TextEditingController? _placeController;

  bool _isEditing = false;
  bool _isInitialized = false;
  File? _pickedProfilePic;
  File? _pickedIdImage;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MainProvider>(context, listen: false);
      provider.fetchUserProfile().then((_) {
        _initializeControllers(provider.userProfile);
      });
    });
  }

  // Initialize controllers with profile data
  void _initializeControllers(ProfileModel? profileData) {
    setState(() {
      _nameController =
          TextEditingController(text: profileData?.username ?? '');
      _emailController = TextEditingController(text: profileData?.email ?? '');
      _phoneController =
          TextEditingController(text: profileData?.phoneNumber ?? '');
      _addressController =
          TextEditingController(text: profileData?.address ?? '');
      _countryController =
          TextEditingController(text: profileData?.country ?? '');
      _districtController =
          TextEditingController(text: profileData?.district ?? '');
      _placeController = TextEditingController(text: profileData?.place ?? '');
      _selectedGender = profileData?.gender;
      _isInitialized = true;
    });
  }

  // Pick profile picture
  Future<void> _pickProfilePicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedProfilePic = File(pickedFile.path);
      });
    }
  }

  
  Future<void> _saveProfile(MainProvider provider) async {
    setState(() {
      _isLoading = true;
    });
  
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
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final bool success = await provider.updateUserProfile(
      address: _addressController!.text.trim(),
      country: _countryController!.text.trim(),
      district: _districtController!.text.trim(),
      place: _placeController!.text.trim(),
      gender: _selectedGender,
      profilePic: _pickedProfilePic,
      idImage: _pickedIdImage,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      setState(() {
        _isEditing = false;
        _pickedProfilePic = null;
        _pickedIdImage = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }


  Widget _buildProfileInfoCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile View'),
      ),
      body: Consumer<MainProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final ProfileModel? profileData = provider.userProfile;
          if (profileData == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No profile data found'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetProfilePage()));
                      // Navigator.pushNamed(context, '/set_profile');
                    },
                    child: Text('Set Up Profile'),
                  ),
                ],
              ),
            );
          }


          if (!_isInitialized) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Picture with Edit Option
                GestureDetector(
                  onTap: _isEditing ? _pickProfilePicture : null,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        // backgroundImage: _pickedProfilePic != null
                        //     ? FileImage(_pickedProfilePic!)
                        //     : (profileData.profilePic != null
                        //         ? NetworkImage(profileData.profilePic!)
                        //         : null),
                        backgroundImage: _pickedProfilePic != null
                            ? FileImage(_pickedProfilePic!)
                            : profileData.profilePic != null
                                ? CachedNetworkImageProvider(
                                    profileData.profilePic!)
                                : null,

                        child: _pickedProfilePic == null &&
                                profileData.profilePic == null
                            ? Icon(Icons.person, size: 60)
                            : null,
                      ),
                      if (_isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xff004CFF),
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),

                // Edit Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Profile Details',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      icon: Icon(_isEditing ? Icons.close : Icons.edit),
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                          _pickedProfilePic = null;
                          _pickedIdImage = null;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),

                // Editable or View Profile Fields
                _isEditing
                    ? Column(
                        children: [
                          // Name Field

                          // Email Field

                          // Phone Number Field

                          // Address Fields
                          _buildEditableField(
                            controller: _addressController!,
                            label: 'Address',
                            icon: Icons.location_on,
                          ),
                          _buildEditableField(
                            controller: _countryController!,
                            label: 'Country',
                            icon: Icons.flag,
                          ),
                          _buildEditableField(
                            controller: _districtController!,
                            label: 'District',
                            icon: Icons.location_city,
                          ),
                          _buildEditableField(
                            controller: _placeController!,
                            label: 'Place',
                            icon: Icons.place,
                          ),
                          // Gender Dropdown

                          // ID Image Upload

                          const SizedBox(height: 16),
                          MaterialButton(
                            color: const Color(0xff004CFF),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () => _saveProfile(provider),
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Save Changes',
                                    style: TextStyle(color: Colors.white),
                                  ),
                            // child: Text('Save Changes',style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildProfileInfoCard(
                            context,
                            icon: Icons.person,
                            label: 'Name',
                            value: _nameController!.text,
                          ),
                          _buildProfileInfoCard(
                            context,
                            icon: Icons.email,
                            label: 'Email',
                            value: _emailController!.text,
                          ),
                          _buildProfileInfoCard(
                            context,
                            icon: Icons.phone,
                            label: 'Phone Number',
                            value: _phoneController!.text,
                          ),
                          _buildProfileInfoCard(
                            context,
                            icon: Icons.location_on,
                            label: 'Address',
                            value: _addressController!.text,
                          ),
                          _buildProfileInfoCard(
                            context,
                            icon: Icons.flag,
                            label: 'Country',
                            value: _countryController!.text,
                          ),
                          _buildProfileInfoCard(
                            context,
                            icon: Icons.location_city,
                            label: 'District',
                            value: _districtController!.text,
                          ),
                          _buildProfileInfoCard(
                            context,
                            icon: Icons.place,
                            label: 'Place',
                            value: _placeController!.text,
                          ),
                          _buildProfileInfoCard(
                            context,
                            icon: Icons.transgender,
                            label: 'Gender',
                            value: _selectedGender ?? 'Not Specified',
                          ),

                          // Additional Profile Details Section
                          const SizedBox(height: 16),
                          Text(
                            'Uploaded ID Image',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: profileData.idImage != null
                                ? Image.network(
                                    profileData.idImage!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Text(
                                          'Failed to load ID image',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                      'No ID Image Uploaded',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _nameController?.dispose();
    _emailController?.dispose();
    _phoneController?.dispose();
    _addressController?.dispose();
    _countryController?.dispose();
    _districtController?.dispose();
    _placeController?.dispose();
    super.dispose();
  }
}
