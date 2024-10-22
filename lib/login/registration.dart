import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'loginpage.dart';

class Registration extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  Registration({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.2,
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Create\nAccount',
                          style:  TextStyle(fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 90),
                    _buildInputField('Enter your Username',_usernameController),
                    const SizedBox(height: 16),
                    _buildInputField('Email',_emailController),
                    const SizedBox(height: 16),
                    _buildInputField('Password',_passwordController, isPassword: true),
                    const SizedBox(height: 16),
                    IntlPhoneField(controller: _numberController,
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
                        print(phone.completeNumber);
                      },
                    ),


                    const Spacer(),
                    MaterialButton(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.13,
                      color: const Color(0xff004CFF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()
                            ));
                      },
                      child: const Text(
                        "Let's get started",
                        style: TextStyle(
                            color: Color(0xffF3F3F3),
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(
                        height: 16),
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String hint,TextEditingController controller ,{bool isPassword = false}) => TextField(
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