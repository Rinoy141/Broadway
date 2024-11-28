
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../providerss/app_provider.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistrationProvider(),
      child: Consumer<RegistrationProvider>(
        builder: (context, provider, child) {
          return WillPopScope(
            onWillPop: () async {
              if (provider.isLoading) {
                return false;
              }
              return true;
            },
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverSafeArea(
                    sliver: SliverPadding(
                      padding: const EdgeInsets.all(24.0),
                      sliver: SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: const Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Create\nAccount',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 90),
                            _buildInputField('Enter your Username', provider.usernameController),
                            const SizedBox(height: 16),
                            _buildInputField('Email', provider.emailController),
                            const SizedBox(height: 16),
                            _buildInputField('Password', provider.passwordController, isPassword: true),
                            const SizedBox(height: 16),
                            IntlPhoneField(
                              decoration: InputDecoration(
                                hintText: 'Your number',
                                hintStyle: const TextStyle(color: Color(0xffD2D2D2)),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              initialCountryCode: 'IN',
                              onChanged: (phone) {
                                provider.updatePhoneNumber(phone.completeNumber);
                              },
                            ),
                            if (provider.errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  provider.errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            const Spacer(),
                            MaterialButton(
                              minWidth: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.width * 0.13,
                              color: const Color(0xff004CFF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17)
                              ),
                              onPressed: provider.isLoading
                                  ? null
                                  : () => provider.register(context),
                              child: provider.isLoading
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Text(
                                "Let's get started",
                                style: TextStyle(
                                    color: Color(0xffF3F3F3),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: provider.isLoading
                                  ? null
                                  : () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField(
      String hint,
      TextEditingController controller, {
        bool isPassword = false,
      }) =>
      TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xffD2D2D2)),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          suffixIcon: isPassword ? const Icon(Icons.visibility_off) : null,
        ),
      );
}