import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providerss/app_provider.dart';
class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notifications'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Common'),
          _buildSwitchTile('General Notification'),
          _buildSwitchTile('Sound'),
          _buildSwitchTile('Vibrate'),
          _buildSectionHeader('System & services update'),
          _buildSwitchTile('App updates'),
          _buildSwitchTile('Bill Reminder'),
          _buildSwitchTile('Promotion'),
          _buildSwitchTile('Discount Available'),
          _buildSwitchTile('Payment Request'),
          _buildSectionHeader('Others'),
          _buildSwitchTile('New Service Available'),
          _buildSwitchTile('New Tips Available'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title) {
    return Consumer<NotificationSettings>(
      builder: (context, settings, child) {
        return SwitchListTile(
          title: Text(title),
          value: settings.getSetting(title),
          onChanged: (_) => settings.toggleSetting(title),
          activeColor: Colors.blue,
        );
      },
    );
  }
}
