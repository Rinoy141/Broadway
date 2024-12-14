import 'package:flutter/material.dart';

class PaymentMethodProvider with ChangeNotifier {
  String _selectedPaymentMethod = '';

  String get selectedPaymentMethod => _selectedPaymentMethod;

  void selectPaymentMethod(String title) {
    _selectedPaymentMethod = title;
    notifyListeners();
  }
}