// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'state providers/bottomnav_provider.dart';

// // class MainPage extends StatelessWidget {
// //   const MainPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {

// //     return ChangeNotifierProvider(
// //       create: (context) => BottomNavBarProvider(),
// //       child: Consumer<BottomNavBarProvider>(
// //         builder: (context, bottomNavBarProvider, child) {
// //           return WillPopScope(
// //             onWillPop: () async {
// //               if (bottomNavBarProvider.selectedIndex != 0) {
// //                 bottomNavBarProvider.onItemTapped(0);
// //                 return false;
// //               }
// //               return true;
// //             },
// //             child: Scaffold(
// //               body: bottomNavBarProvider.currentPage,
// //               bottomNavigationBar: BottomNavigationBar(
// //                 items: const <BottomNavigationBarItem>[
// //                   BottomNavigationBarItem(
// //                     icon: Icon(Icons.home),
// //                     label: 'Home',
// //                   ),
// //                   BottomNavigationBarItem(
// //                     icon: Icon(Icons.search),
// //                     label: 'Search',
// //                   ),
// //                   BottomNavigationBarItem(
// //                     icon: Icon(Icons.shopping_cart),
// //                     label: 'Cart',
// //                   ),
// //                   BottomNavigationBarItem(
// //                     icon: Icon(Icons.history),
// //                     label: 'Orders',
// //                   ),
// //                   BottomNavigationBarItem(
// //                     icon: Icon(Icons.person),
// //                     label: 'Profile',
// //                   ),
// //                 ],
// //                 currentIndex: bottomNavBarProvider.selectedIndex,
// //                 selectedItemColor: Colors.blue,
// //                 unselectedItemColor: Colors.grey,
// //                 onTap: bottomNavBarProvider.onItemTapped,
// //                 type: BottomNavigationBarType.fixed,
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'state providers/bottomnav_provider.dart';

// class MainPage extends StatelessWidget {
//   const MainPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => BottomNavBarProvider(),
//       child: Consumer<BottomNavBarProvider>(
//         builder: (context, bottomNavBarProvider, child) {
//           return WillPopScope(
//             onWillPop: () async {
//               if (bottomNavBarProvider.selectedIndex != 0) {
//                 bottomNavBarProvider.onItemTapped(0);
//                 return false;
//               }
//               return true;
//             },
//             child: Scaffold(
//               extendBody: true,
//               body: bottomNavBarProvider.currentPage,
//               bottomNavigationBar: bottomNavBarProvider.selectedIndex == 2
//                   ? null // Hide the bottom navigation bar when Cart is selected
//                   : Container(
//                       margin: const EdgeInsets.all(5.0),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 5.0, vertical: 5.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                           BoxShadow(
//                             color: Colors.white.withOpacity(0.8),
//                             blurRadius: 20,
//                             offset: const Offset(-5, -5),
//                           ),
//                         ],
//                       ),
//                       child: BottomNavigationBar(
//                         items: const <BottomNavigationBarItem>[
//                           BottomNavigationBarItem(
//                             icon: Icon(Icons.home_rounded),
//                             label: '',
//                           ),
//                           BottomNavigationBarItem(
//                             icon: Icon(Icons.search_rounded),
//                             label: '',
//                           ),
//                           BottomNavigationBarItem(
//                             icon: Icon(Icons.shopping_cart_rounded),
//                             label: '',
//                           ),
//                           BottomNavigationBarItem(
//                             icon: Icon(Icons.history_rounded),
//                             label: '',
//                           ),
//                           BottomNavigationBarItem(
//                             icon: Icon(Icons.person_rounded),
//                             label: '',
//                           ),
//                         ],
//                         currentIndex: bottomNavBarProvider.selectedIndex,
//                         selectedItemColor: Colors.orange,
//                         unselectedItemColor: Colors.black,
//                         onTap: bottomNavBarProvider.onItemTapped,
//                         type: BottomNavigationBarType.fixed,
//                         elevation: 0,
//                         backgroundColor: Colors.transparent,
//                         showSelectedLabels: false,
//                         showUnselectedLabels: false,
//                       ),
//                     ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state providers/bottomnav_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavBarProvider(),
      child: Consumer<BottomNavBarProvider>(
        builder: (context, bottomNavBarProvider, child) {
          return WillPopScope(
            onWillPop: () async {
              if (bottomNavBarProvider.selectedIndex != 0) {
                bottomNavBarProvider.onItemTapped(0);
                return false;
              }
              return true;
            },
            child: Scaffold(
              extendBody: true,
              body: bottomNavBarProvider.currentPage,
              bottomNavigationBar: bottomNavBarProvider.selectedIndex == 2
                  ? null
                  : Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.grey.shade200, 
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1), 
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: BottomNavigationBar(
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home_rounded),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.search_rounded),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.shopping_cart_rounded),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.history_rounded),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person_rounded),
                            label: '',
                          ),
                        ],
                        currentIndex: bottomNavBarProvider.selectedIndex,
                        selectedItemColor: Colors.orange,
                        unselectedItemColor: Colors.black,
                        onTap: bottomNavBarProvider.onItemTapped,
                        type: BottomNavigationBarType.fixed,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
