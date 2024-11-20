
import 'package:broadway/food_app/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providerss/app_provider.dart';
import 'appbar.dart';







class RatingProvider with ChangeNotifier {
  int _driverRating = 5;
  int _shopRating = 5;
  List<String> _selectedDriverTags = [];
  List<String> _selectedShopTags = [];
  String _driverComment = '';
  String _shopComment = '';

  int get driverRating => _driverRating;
  int get shopRating => _shopRating;
  List<String> get selectedDriverTags => _selectedDriverTags;
  List<String> get selectedShopTags => _selectedShopTags;
  String get driverComment => _driverComment;
  String get shopComment => _shopComment;

  void setDriverRating(int rating) {
    _driverRating = rating;
    notifyListeners();
  }

  void setShopRating(int rating) {
    _shopRating = rating;
    notifyListeners();
  }

  void toggleDriverTag(String tag) {
    if (_selectedDriverTags.contains(tag)) {
      _selectedDriverTags.remove(tag);
    } else {
      _selectedDriverTags.add(tag);
    }
    notifyListeners();
  }

  void toggleShopTag(String tag) {
    if (_selectedShopTags.contains(tag)) {
      _selectedShopTags.remove(tag);
    } else {
      _selectedShopTags.add(tag);
    }
    notifyListeners();
  }

  void setDriverComment(String comment) {
    _driverComment = comment;
    notifyListeners();
  }

  void setShopComment(String comment) {
    _shopComment = comment;
    notifyListeners();
  }

  void submitRatings() {
    // Here you would typically send the ratings to your backend
    print('Driver Rating: $_driverRating');
    print('Shop Rating: $_shopRating');
    print('Driver Tags: $_selectedDriverTags');
    print('Shop Tags: $_selectedShopTags');
    print('Driver Comment: $_driverComment');
    print('Shop Comment: $_shopComment');

    // Reset the ratings after submission
    _driverRating = 5;
    _shopRating = 5;
    _selectedDriverTags = [];
    _selectedShopTags = [];
    _driverComment = '';
    _shopComment = '';
    notifyListeners();
  }
}
class SearchModel extends ChangeNotifier {
  // Reference to RestaurantProvider to access the list of restaurants
  final LoginProvider _loginProvider;
  List<Restaurant> _restaurants = [];
  List<Restaurant> _filteredRestaurants = [];

  SearchModel(this._loginProvider) {
    // Initialize the restaurant list from the provider
    _restaurants = _loginProvider.restaurants;
    _filteredRestaurants = _restaurants;
  }

  List<Restaurant> get filteredRestaurants => _filteredRestaurants;

  void filterSearchResults(String query) {
    _filteredRestaurants = _restaurants
        .where((restaurant) =>
        restaurant.restaurantName.toLowerCase().contains(query.toLowerCase())
    )
        .toList();
    notifyListeners();
  }
}


class AppBarState extends ChangeNotifier {
  bool _isFilterOpen = false;
  String _selectedTab = 'Category';
  String _sortBy = 'Popularity';

  bool get isFilterOpen => _isFilterOpen;
  String get selectedTab => _selectedTab;
  String get sortBy => _sortBy;

  void toggleFilter() {
    _isFilterOpen = !_isFilterOpen;
    notifyListeners();
  }

  void setSelectedTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  void setSortBy(String sort) {
    _sortBy = sort;
    notifyListeners();
  }
}
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppBarState(),
      child: const CustomAppBarContent(),
    );
  }
}






