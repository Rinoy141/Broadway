// import 'package:broadway/food_app/confirm_order_page.dart';
// import 'package:broadway/food_app/order_history%20page.dart';
// import 'package:broadway/login/loginpage.dart';
// import 'package:broadway/profile/notficiation.dart';
// import 'package:broadway/profile/view_profile.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/bottomnav_provider.dart';
// import '../providerss/app_provider.dart';


// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           UserInfoHeader(),
//           ListTile(
//             title: Text('View Profile'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfileViewPage()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('Notification'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NotificationsScreen()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('My Orders'),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => OrderHistoryPage())
//               );
//             },
//           ),
//           ListTile(
//             title: Text('My Wishlist'),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CartPage())
//               );
//             },
//           ),
//           ListTile(title: Text('Jobs Posted')),
//           ListTile(title: Text('Talk to our Support')),
//           ListTile(title: Text('Mail to us')),
//           ListTile(
//             title: Text('Log out'),
//             leading: Icon(Icons.logout, color: Colors.red),
//             onTap: () {
//               // Provider.of<MainProvider>(context, listen: false).logout();

//               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UserInfoHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundImage: NetworkImage('https://example.com/placeholder.jpg'),
//           ),
//           SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Amal John',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 '01XXXXXXXXXXXX',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:broadway/food_app/confirm_order_page.dart';
import 'package:broadway/food_app/order_history%20page.dart';
import 'package:broadway/food_app/restaurant_model.dart';
import 'package:broadway/login/loginpage.dart';
import 'package:broadway/onbrding_screen/onbrding_screen.dart';
import 'package:broadway/profile/notficiation.dart';
import 'package:broadway/profile/view_profile.dart';
import 'package:broadway/providerss/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ProfileScreen extends StatelessWidget {
  Future<bool> logout(BuildContext context) async {
  const String url = 'http://broadway.icgedu.com/user/logout/';
  Dio _dio = Dio();

  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cookieString = prefs.getString('cookieString');
    print('Cookies before logout: $cookieString');

    final response = await _dio.post(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookieString ?? '',
        },
      ),
    );

    print('Logout response status: ${response.statusCode}');
    print('Logout response data: ${response.data}');

    if (response.statusCode == 200 && response.data['detail'] == 'Successfully logged out.') {
      print('Logout successful: ${response.data['detail']}');

      await prefs.clear();
      print('SharedPreferences cleared.');

      // Ensure navigation happens only after logout is complete
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully logged out.')),
        );
      }

      return true;
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['detail'] ?? 'Failed to log out.')),
        );
      }
      return false;
    }
  } catch (e) {
    print('Error during logout: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
    return false;
  }
}



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
                  MaterialPageRoute(builder: (context) => OrderHistoryPage()),
              );
            },
          ),
          ListTile(
            title: Text('My Wishlist'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
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
              logout(context); // Call the logout function
            },
          ),
        ],
      ),
    );
  }
}

// class UserInfoHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundImage: NetworkImage('https://example.com/placeholder.jpg'),
//           ),
//           SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Amal John',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 '01XXXXXXXXXXXX',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


class UserInfoHeader extends StatefulWidget {
  @override
  _UserInfoHeaderState createState() => _UserInfoHeaderState();
}

class _UserInfoHeaderState extends State<UserInfoHeader> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MainProvider>(context, listen: false).fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {

        ProfileModel? userProfile = provider.userProfile;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: userProfile?.profilePic != null
                    ? NetworkImage(userProfile!.profilePic!)
                    : AssetImage('Assets/images/image 4.png'),
                child: userProfile == null
                    ? CircularProgressIndicator()
                    : null,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfile?.username ?? 'Loading...',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userProfile?.phoneNumber ?? 'Phone number',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}