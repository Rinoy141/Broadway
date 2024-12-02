import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerss/app_provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Consumer<MainProvider>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: provider.newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: provider.confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MaterialButton(
                minWidth: double.infinity,
                height: 50,
                color: const Color(0xff004CFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                onPressed: () => provider.changePassword(context),
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}