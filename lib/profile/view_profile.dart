import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../food_app/restaurant_model.dart';
import '../food_app/state providers/profile_provider.dart';
import '../providerss/app_provider.dart';
import '../profile/set_profile.dart';

class ProfileViewPage extends StatefulWidget {
  @override
  _ProfileViewPageState createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      final profileViewProvider = Provider.of<ProfileViewProvider>(context, listen: false);

      mainProvider.fetchUserProfile().then((_) {
        profileViewProvider.initializeControllers(mainProvider.userProfile);
      });
    });
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
      body: Consumer2<MainProvider, ProfileViewProvider>(
        builder: (context, mainProvider, profileViewProvider, child) {
          if (mainProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final ProfileModel? profileData = mainProvider.userProfile;
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
                              builder: (context) => SetProfilePage()
                          )
                      );
                    },
                    child: Text('Set Up Profile'),
                  ),
                ],
              ),
            );
          }

          if (!profileViewProvider.isInitialized) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: profileViewProvider.isEditing
                      ? () => profileViewProvider.pickProfilePicture()
                      : null,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: profileViewProvider.pickedProfilePic != null
                            ? FileImage(profileViewProvider.pickedProfilePic!)
                            : profileData.profilePic != null
                            ? CachedNetworkImageProvider(
                            profileData.profilePic!)
                            : null,
                        child: profileViewProvider.pickedProfilePic == null &&
                            profileData.profilePic == null
                            ? Icon(Icons.person, size: 60)
                            : null,
                      ),
                      if (profileViewProvider.isEditing)
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
                      icon: Icon(profileViewProvider.isEditing ? Icons.close : Icons.edit),
                      onPressed: () => profileViewProvider.toggleEditMode(),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),

                // Editable or View Profile Fields
                profileViewProvider.isEditing
                    ? Column(
                  children: [
                    // Address Fields
                    _buildEditableField(
                      controller: profileViewProvider.addressController!,
                      label: 'Address',
                      icon: Icons.location_on,
                    ),
                    _buildEditableField(
                      controller: profileViewProvider.countryController!,
                      label: 'Country',
                      icon: Icons.flag,
                    ),
                    _buildEditableField(
                      controller: profileViewProvider.districtController!,
                      label: 'District',
                      icon: Icons.location_city,
                    ),
                    _buildEditableField(
                      controller: profileViewProvider.placeController!,
                      label: 'Place',
                      icon: Icons.place,
                    ),

                    const SizedBox(height: 16),
                    MaterialButton(
                      color: const Color(0xff004CFF),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () => profileViewProvider.saveProfile(mainProvider, context),
                      child: profileViewProvider.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                        'Save Changes',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
                    : Column(
                  children: [
                    _buildProfileInfoCard(
                      context,
                      icon: Icons.person,
                      label: 'Name',
                      value: profileViewProvider.nameController!.text,
                    ),
                    _buildProfileInfoCard(
                      context,
                      icon: Icons.email,
                      label: 'Email',
                      value: profileViewProvider.emailController!.text,
                    ),
                    _buildProfileInfoCard(
                      context,
                      icon: Icons.phone,
                      label: 'Phone Number',
                      value: profileViewProvider.phoneController!.text,
                    ),
                    _buildProfileInfoCard(
                      context,
                      icon: Icons.location_on,
                      label: 'Address',
                      value: profileViewProvider.addressController!.text,
                    ),
                    _buildProfileInfoCard(
                      context,
                      icon: Icons.flag,
                      label: 'Country',
                      value: profileViewProvider.countryController!.text,
                    ),
                    _buildProfileInfoCard(
                      context,
                      icon: Icons.location_city,
                      label: 'District',
                      value: profileViewProvider.districtController!.text,
                    ),
                    _buildProfileInfoCard(
                      context,
                      icon: Icons.place,
                      label: 'Place',
                      value: profileViewProvider.placeController!.text,
                    ),
                    _buildProfileInfoCard(
                      context,
                      icon: Icons.transgender,
                      label: 'Gender',
                      value: profileViewProvider.selectedGender ?? 'Not Specified',
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

  // @override
  // void dispose() {
  //   Provider.of<ProfileViewProvider>(context, listen: false).disposeControllers();
  //   super.dispose();
  // }

  @override
void dispose() {
  try {
    final profileProvider = Provider.of<ProfileViewProvider>(context, listen: false);
    profileProvider.disposeControllers();
  } catch (e) {
    // Log or handle the error gracefully
    debugPrint('Error disposing ProfileViewProvider: $e');
  }
  super.dispose();
}

}