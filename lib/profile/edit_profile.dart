import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? selectedCountry = 'United States';
  String? selectedGender = 'Female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(decoration: InputDecoration(labelText: 'Full name')),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(decoration: InputDecoration(labelText: 'id card')),
                ),
                TextButton(onPressed: () {}, child: Text('upload')),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Label',
                hintText: 'youremail@domain.',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone number',

              ),
              initialValue: '123-456-7890',
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Country'),
              value: selectedCountry,
              items: ['United States', 'Canada', 'UK'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCountry = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Genre'),
              value: selectedGender,
              items: ['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              initialValue: '45 New, New York',
            ),
            SizedBox(height: 32),
            ElevatedButton(
              child: Text('SUBMIT'),
              onPressed: () {
                // Handle submit logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}