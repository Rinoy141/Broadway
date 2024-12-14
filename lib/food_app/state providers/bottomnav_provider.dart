import 'package:broadway/food_app/search_br.dart';
import 'package:broadway/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import '../confirm_order_page.dart';
import '../food_delivery_homepage.dart';
import '../order_history page.dart';


class BottomNavBarProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<Widget> _pages = [
    FoodDeliveryHomePage(),
    SearchPage(),
    CartPage(),
    OrderHistoryPage(),
    ProfileScreen(),
  ];

  Widget get currentPage => _pages[_selectedIndex];

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

