import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerss/app_provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController addressController;
  late TextEditingController countryController;
  late TextEditingController districtController;
  late TextEditingController placeController;
  late TextEditingController genderController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    addressController = TextEditingController();
    countryController = TextEditingController();
    districtController = TextEditingController();
    placeController = TextEditingController();
    genderController = TextEditingController();

    // Optionally, you could populate controllers with initial data if needed
    final provider = Provider.of<MainProvider>(context, listen: false);
    addressController.text = provider.emailController.text; // Example binding
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    addressController.dispose();
    countryController.dispose();
    districtController.dispose();
    placeController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => MainProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<MainProvider>(
            builder: (context, loginProvider, _) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Address is required' : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: countryController,
                        decoration: const InputDecoration(
                          labelText: 'Country',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Country is required' : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: districtController,
                        decoration: const InputDecoration(
                          labelText: 'District',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'District is required' : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: placeController,
                        decoration: const InputDecoration(
                          labelText: 'Place',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Place is required' : null,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: genderController,
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Gender is required' : null,
                      ),
                      const SizedBox(height: 24.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Use handleAddressUpdate instead of addOrUpdateAddress directly
                            await loginProvider.handleAddressUpdate(
                              context: context,
                              country: countryController.text.trim(),
                              address: addressController.text.trim(),
                              district: districtController.text.trim(),
                              place: placeController.text.trim(),
                              gender: genderController.text.trim(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Save Profile'),
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
