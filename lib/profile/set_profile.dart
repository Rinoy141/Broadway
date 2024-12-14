import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../food_app/state providers/set_profile_provider.dart';
import '../providerss/app_provider.dart';

class SetProfilePage extends StatefulWidget {
  @override
  SetProfilePageState createState() => SetProfilePageState();
}

class SetProfilePageState extends State<SetProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize provider data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileSetupProvider =
      Provider.of<ProfileSetupProvider>(context, listen: false);
      final mainProvider =
      Provider.of<MainProvider>(context, listen: false);

      // Pre-fill email address
      profileSetupProvider.addressController.text =
          mainProvider.emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileSetupProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Set Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ProfileSetupProvider>(
            builder: (context, profileSetupProvider, _) {
              return Consumer<MainProvider>(
                builder: (context, mainProvider, _) {
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Profile Image Picker
                          GestureDetector(
                            onTap: () => profileSetupProvider.pickImage(true),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[200],
                              backgroundImage:
                              profileSetupProvider.profileImage != null
                                  ? FileImage(profileSetupProvider.profileImage!)
                                  : null,
                              child: profileSetupProvider.profileImage == null
                                  ? Icon(Icons.camera_alt,
                                  size: 50, color: Colors.grey[800])
                                  : null,
                            ),
                          ),

                          // Additional form fields
                          TextFormField(
                            controller: profileSetupProvider.countryController,
                            decoration: InputDecoration(
                              labelText: 'Country',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter country';
                              }
                              return null;
                            },
                          ),

                          TextFormField(
                            controller: profileSetupProvider.districtController,
                            decoration: InputDecoration(
                              labelText: 'District',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter district';
                              }
                              return null;
                            },
                          ),

                          // ID Image Picker
                          ElevatedButton(
                            onPressed: () => profileSetupProvider.pickImage(false),
                            child: Text('Pick ID Image'),
                          ),

                          MaterialButton(
                            minWidth: 300,
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  profileSetupProvider.validateForm()) {
                                await mainProvider.handleAddressUpdate(
                                  context: context,
                                  country: profileSetupProvider.countryController.text.trim(),
                                  address: profileSetupProvider.addressController.text.trim(),
                                  district: profileSetupProvider.districtController.text.trim(),
                                  place: profileSetupProvider.placeController.text.trim(),
                                  gender: profileSetupProvider.genderController.text.trim(),
                                  profilePic: profileSetupProvider.profileImage,
                                  idImage: profileSetupProvider.idImage,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please fill all fields and upload both Profile Picture and ID Image'),
                                  ),
                                );
                              }
                            },
                            color: const Color(0xff004CFF),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              'Submit your profile',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}