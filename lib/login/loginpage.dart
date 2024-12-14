import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'forgot_pass_page.dart';

import '../providerss/app_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_) => MainProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: screenHeight * 0.25,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Consumer<MainProvider>(
                    builder: (context, loginProvider, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Welcome back! Dive right in and discover what's new.",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextField(
                          controller: loginProvider.emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: loginProvider.passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                  ));
                            },
                            style: const ButtonStyle(
                                alignment: Alignment.centerRight),
                            child: const Text('forgot password'),
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (loginProvider.isLoading)
                          Center(child: CircularProgressIndicator())
                        else
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.width * 0.13,
                            color: const Color(0xff004CFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            onPressed: loginProvider.isLoading
                                ? null
                                : () {
                                    loginProvider.handleLogin(context);
                                  },
                            child: Center(
                              child: loginProvider.isLoading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xffF3F3F3)),
                                    )
                                  : const Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Color(0xffF3F3F3),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
