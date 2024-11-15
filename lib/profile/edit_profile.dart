import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerss/app_provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
    // Initialize the provider when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EditProfileProvider>(context, listen: false).initializeProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<EditProfileProvider>(
            builder: (context, editProfileProvider, _) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: editProfileProvider.address,
                      onChanged: (value) {
                        editProfileProvider.address = value;
                        print('DEBUG: Address updated to: $value');
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Country',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: editProfileProvider.country,
                      onChanged: (value) {
                        editProfileProvider.country = value;
                        print('DEBUG: Country updated to: $value');
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'District',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: editProfileProvider.district,
                      onChanged: (value) {
                        editProfileProvider.district = value;
                        print('DEBUG: District updated to: $value');
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Place',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: editProfileProvider.place,
                      onChanged: (value) {
                        editProfileProvider.place = value;
                        print('DEBUG: Place updated to: $value');
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: editProfileProvider.gender,
                      onChanged: (value) {
                        editProfileProvider.gender = value;
                        print('DEBUG: Gender updated to: $value');
                      },
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final result = await editProfileProvider.updateUserData();
                          if (result['success']) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result['message']),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result['message']),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          print('ERROR in save button: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('An error occurred while saving'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Save Profile'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}