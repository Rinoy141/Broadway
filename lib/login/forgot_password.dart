import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:broadway/login/password_rec_provider.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildRecoveryOptions(),
                  const SizedBox(height: 30),
                  Consumer<PasswordRecoveryProvider>(
                    builder: (context, provider, child) {
                      return provider.codeSent
                          ? _buildCodeInputSection(context, provider)
                          : _buildSendCodeButton(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.lock_outline, size: 40, color: Colors.blue),
        ),
        const SizedBox(height: 20),
        const Text(
          'Password Recovery',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'How would you like to restore\nyour password?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildRecoveryOptions() {
    return Consumer<PasswordRecoveryProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionButton('SMS', provider.smsSelected, () => provider.setSmsSelected(true), Colors.blue),
            const SizedBox(width: 20),
            _buildOptionButton('Email', !provider.smsSelected, () => provider.setSmsSelected(false), Colors.pink),
          ],
        );
      },
    );
  }

  Widget _buildOptionButton(String text, bool isSelected, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(border: Border.all(style: BorderStyle.none),
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),

        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                  width: 2,
                ),
                color: isSelected ? color : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendCodeButton(BuildContext context) {
    return Consumer<PasswordRecoveryProvider>(
      builder: (context, provider, child) {
        return ElevatedButton(
          onPressed: () {
            provider.sendCode();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(provider.smsSelected
                  ? 'SMS code sent to your phone'
                  : 'Reset link sent to your email')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: provider.smsSelected ? Colors.blue : Colors.pink,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          child: Text(provider.smsSelected ? 'Send SMS Code' : 'Send Email',style: const TextStyle(color: Colors.white),),
        );
      },
    );
  }

  Widget _buildCodeInputSection(BuildContext context, PasswordRecoveryProvider provider) {
    return Column(
      children: [
        Text(
          provider.smsSelected
              ? 'Enter 4-digit code we sent you\non your phone number'
              : 'Enter the code we sent to your email',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        provider.smsSelected
            ? _buildSmsCodeInput(provider,context)
            : _buildEmailCodeInput(provider),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            provider.verifyCode();
            // You might want to add some feedback to the user here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: provider.smsSelected ? Colors.blue : Colors.pink,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          child: const Text('Verify',style: TextStyle(color: Colors.white),),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => provider.sendCode(),
          style: ElevatedButton.styleFrom(
            backgroundColor: provider.smsSelected ? Colors.blue : Colors.pink,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          ),
          child: const Text('Send Again',style: TextStyle(color: Colors.white),),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            provider.cancel();
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildSmsCodeInput(PasswordRecoveryProvider provider,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
            (index) => Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            onChanged: (value) {
              provider.setOtpCode(index, value);
              if (value.length == 1 && index < 3) {
                FocusScope.of(context).nextFocus();
              }
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              counterText: '',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailCodeInput(PasswordRecoveryProvider provider) {
    return TextField(
      onChanged: (value) => provider.setEmailCode(value),
      decoration: InputDecoration(
        hintText: 'Enter code',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}