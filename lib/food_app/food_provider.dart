import 'package:broadway/food_app/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'food_details_page.dart';

class RestaurantProvider with ChangeNotifier {
  final List<Restaurant> _restaurants = [
    Restaurant(
      name: 'Burger King',
      location: 'Kochi',
      image: 'Assets/image 6.png',
      isOpen: true,
      rating: 4.5,
      distance: '1.2 km',
      deliveryTime: '15 Mins',
      popularItems: [
        PopularItem(
          name: 'Double Cheese Burger',
          price: 5.99,
          category: 'Burger',
          imageUrl: 'Assets/image 6.png',
        ),
        PopularItem(
          name: 'Veg Burger',
          price: 7.99,
          category: 'Burger',
          imageUrl: 'Assets/image 6.png',
        ),
        PopularItem(
          name: 'Potato Wedges',
          price: 3.99,
          category: 'Sides',
          imageUrl: 'Assets/image 6.png',
        ),
      ],
      foodCategories: [
        ItemCategory(
          name: 'Hot Burger Combo',
          items: [
            Item(
              name: 'Combo Spicy Tender',
              prices: {'S': 8.99, 'M': 10.15, 'L': 11.99},
              imageUrl: 'Assets/image 6.png',
              description: 'Tender grilled spicy chicken combo',
              category: 'Burger Combo',
            ),
            Item(
              name: 'Combo Tender Grilled',
              prices: {'S': 8.99, 'M': 10.15, 'L': 11.99},
              imageUrl: 'Assets/image 6.png',
              description: 'Tender grilled chicken combo',
              category: 'Burger Combo',
            ),
          ],
        ),
        ItemCategory(
          name: 'Fried Chicken',
          items: [
            Item(
              name: 'Chicken BBQ',
              prices: {'S': 9.99, 'M': 11.99, 'L': 13.99},
              imageUrl: 'Assets/image 6.png',
              description: 'BBQ chicken with sides',
              category: 'Chicken',
            ),
            Item(
              name: 'Combo Chicken Crispy',
              prices: {'S': 9.99, 'M': 11.99, 'L': 13.99},
              imageUrl: 'Assets/image 6.png',
              description: 'Crispy chicken combo',
              category: 'Chicken',
            ),
          ],
        ),
      ],
    ),
    Restaurant(
      name: 'Dominos',
      location: 'Thrissur',
      image: 'Assets/image 6.png',
      isOpen: true,
      rating: 4.5,
      distance: '2.5 km',
      deliveryTime: '15 Mins',
      popularItems: [
        PopularItem(
          name: 'Extreme Cheese',
          price: 5.99,
          category: 'Burger',
          imageUrl: 'Assets/image 6.png',
        ),
        PopularItem(
          name: 'Bacon Cheese Burger',
          price: 7.99,
          category: 'Burger',
          imageUrl: 'Assets/image 6.png',
        ),
        PopularItem(
          name: 'Potato Wedges',
          price: 3.99,
          category: 'Sides',
          imageUrl: 'Assets/image 6.png',
        ),
      ],
      foodCategories: [
        ItemCategory(
          name: 'Hot Burger Combo',
          items: [
            Item(
              name: 'Combo Spicy Tender',
              prices: {'S': 8.99, 'M': 10.15, 'L': 11.99},
              imageUrl: 'Assets/image 6.png',
              description: 'Tender grilled spicy chicken combo',
              category: 'Burger Combo',
            ),
            Item(
              name: 'Combo BBQ Bacon',
              prices: {'S': 8.99, 'M': 10.15, 'L': 11.99},
              imageUrl: 'Assets/image 6.png',
              description: 'BBQ bacon and chicken combo',
              category: 'Burger Combo',
            ),
          ],
        ),
        ItemCategory(
          name: 'Fried Chicken',
          items: [
            Item(
              name: 'Chicken BBQ',
              prices: {'S': 9.99, 'M': 11.99, 'L': 13.99},
              imageUrl: 'Assets/image 6.png',
              description: 'BBQ chicken with sides',
              category: 'Chicken',
            ),
            Item(
              name: 'Combo Chicken Crispy',
              prices: {'S': 9.99, 'M': 11.99, 'L': 13.99},
              imageUrl: 'Assets/image 6.png',
              description: 'Crispy chicken combo',
              category: 'Chicken',
            ),
          ],
        ),
      ],
    ),
  ];


  List<Restaurant> get restaurants => _restaurants;

  // Optionally add more methods to modify or fetch data
  void addRestaurant(Restaurant restaurant) {
    _restaurants.add(restaurant);
    notifyListeners();
  }
  String _selectedSize = 'M';
  int _quantity = 1;

  String get selectedSize => _selectedSize;
  int get quantity => _quantity;

  void setSelectedSize(String size) {
    _selectedSize = size;
    notifyListeners();
  }

  void updateQuantity(int change) {
    _quantity = (_quantity + change).clamp(1, 10);
    notifyListeners();
  }
}




class SearchModel extends ChangeNotifier {
  // Reference to RestaurantProvider to access the list of restaurants
  final RestaurantProvider _restaurantProvider;
  List<Restaurant> _restaurants = [];
  List<Restaurant> _filteredRestaurants = [];

  SearchModel(this._restaurantProvider) {
    // Initialize the restaurant list from the provider
    _restaurants = _restaurantProvider.restaurants;
    _filteredRestaurants = _restaurants;
  }

  List<Restaurant> get filteredRestaurants => _filteredRestaurants;

  void filterSearchResults(String query) {
    _filteredRestaurants = _restaurants
        .where((restaurant) =>
        restaurant.name.toLowerCase().contains(query.toLowerCase())
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







