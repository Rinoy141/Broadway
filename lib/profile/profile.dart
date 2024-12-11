import 'package:broadway/food_app/confirm_order_page.dart';
import 'package:broadway/food_app/order_history%20page.dart';
import 'package:broadway/login/loginpage.dart';
import 'package:broadway/profile/notficiation.dart';
import 'package:broadway/profile/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerss/app_provider.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UserInfoHeader(),
          ListTile(
            title: Text('View Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileViewPage()),
              );
            },
          ),
          ListTile(
            title: Text('Notification'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
          ListTile(
            title: Text('My Orders'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistoryPage())
              );
            },
          ),
          ListTile(
            title: Text('My Wishlist'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage())
              );
            },
          ),
          ListTile(title: Text('Jobs Posted')),
          ListTile(title: Text('Talk to our Support')),
          ListTile(title: Text('Mail to us')),
          ListTile(
            title: Text('Log out'),
            leading: Icon(Icons.logout, color: Colors.red),
            onTap: () {

              Provider.of<MainProvider>(context, listen: false).logout();

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            },
          ),
        ],
      ),
    );
  }
}

class UserInfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://example.com/placeholder.jpg'),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amal John',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '01XXXXXXXXXXXX',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}