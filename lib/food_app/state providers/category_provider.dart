import 'package:flutter/cupertino.dart';

import '../../providerss/app_provider.dart';
import '../restaurant_model.dart';

class MenuProvider with ChangeNotifier {
  List<MenuItem> _menuItems = [];
  bool _isLoading = false;

  List<MenuItem> get menuItems => _menuItems;
  bool get isLoading => _isLoading;

  Future<void> fetchMenuItems(int categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {

      _menuItems = await MainProvider().getMenuItemsByCategory(categoryId);
    } catch (e) {

      print('Error fetching menu items: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}