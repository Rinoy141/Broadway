import 'package:flutter/cupertino.dart';

class PasswordRecoveryProvider with ChangeNotifier {
  bool _smsSelected = true;
  List<String> _otpCode = ['', '', '', ''];
  String _emailCode = '';
  bool _codeSent = false;

  bool get smsSelected => _smsSelected;
  String get otpCode => _otpCode.join();
  String get emailCode => _emailCode;
  bool get codeSent => _codeSent;

  void setSmsSelected(bool value) {
    _smsSelected = value;
    notifyListeners();
  }

  void setOtpCode(int index, String value) {
    _otpCode[index] = value;
    notifyListeners();
  }

  void setEmailCode(String value) {
    _emailCode = value;
    notifyListeners();
  }

  void sendCode() {
    // Implement send code logic
    _codeSent = true;
    print(_smsSelected ? 'Sending SMS code' : 'Sending email code');
    notifyListeners();
  }

  void verifyCode() {
    // Implement verify code logic
    print('Verifying code: ${_smsSelected ? otpCode : emailCode}');
  }

  void cancel() {
    // Implement cancel logic
    _codeSent = false;
    _otpCode = ['', '', '', ''];
    _emailCode = '';
    notifyListeners();
  }
}