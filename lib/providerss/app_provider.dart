import 'package:flutter/material.dart';


// NotificationSettings model
class NotificationSettings extends ChangeNotifier {
  final Map<String, bool> _settings = {
    'General Notification': true,
    'Sound': false,
    'Vibrate': true,
    'App updates': false,
    'Bill Reminder': true,
    'Promotion': true,
    'Discount Available': false,
    'Payment Request': false,
    'New Service Available': false,
    'New Tips Available': true,
  };

  bool getSetting(String key) => _settings[key] ?? false;

  void toggleSetting(String key) {
    _settings[key] = !(_settings[key] ?? false);
    notifyListeners();
  }
}