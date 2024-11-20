// import 'package:broadway/profile/notficiation.dart';
// import 'package:flutter/material.dart';
//
// import 'edit_profile.dart';
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           UserInfoHeader(),
//           ListTile(
//             title: Text('Edit Profile'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => EditProfilePage()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('notification'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NotificationsScreen()),
//               );
//             },
//           ),
//           ListTile(title: Text('My Orders')),
//           ListTile(title: Text('My Wishlist')),
//           ListTile(title: Text('Jobs Posted')),
//           ListTile(title: Text('Talk to our Support')),
//           ListTile(title: Text('Mail to us')),
//           ListTile(
//             title: Text('Log out'),
//             leading: Icon(Icons.logout, color: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class UserInfoHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundImage:
//                 NetworkImage('https://example.com/placeholder.jpg'),
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
