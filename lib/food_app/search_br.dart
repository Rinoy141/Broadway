import 'package:broadway/food_app/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerss/app_provider.dart';
import 'food_details_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, loginProvider, _) => Scaffold(
          appBar: AppBar(
            title: TextField(
              autofocus: true,
              onChanged: (query) => loginProvider.searchMenuAndRestaurants(query),
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          body: _buildSearchResults(context, loginProvider),
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, LoginProvider loginProvider) {
    final searchResults = loginProvider.currentSearchResults ?? [];

    if (loginProvider.currentSearchResults == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (searchResults.isEmpty) {
      return const Center(
        child: Text('No results found'),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        final isMenuItem = item.containsKey('Item');

        return ListTile(
          leading: item['Image'] != null
              ? Image.network(
            item['Image'],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                isMenuItem ? Icons.fastfood : Icons.restaurant,
                color: Theme.of(context).primaryColor,
              );
            },
          )
              : Icon(
            isMenuItem ? Icons.fastfood : Icons.restaurant,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            isMenuItem
                ? '${item['Item']} (${item['Restaurant_Name']})'
                : (item['Restaurant_Name'] ?? 'Unknown'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            isMenuItem
                ? '${item['Category'] ?? ''} • ₹${item['Price'] ?? ''}'
                : '${item['District'] ?? ''} ${item['Place'] != null ? '• ${item['Place']}' : ''}',
          ),
          onTap: () => _navigateToRestaurantDetails(context, item),
        );
      },
    );
  }

  void _navigateToRestaurantDetails(BuildContext context, dynamic item) {
    try {
      // Check if all required fields are present
      final restaurant = Restaurant(
        id: item['Restaurant_id'] ?? item['id'],
        restaurantName: item['Restaurant_Name'] ?? 'Unknown',
        district: item['District'] ?? 'Unknown District',
        place: item['Place'] ?? 'Unknown Place',
        averageRating: (item['Rating'] ?? 0).toDouble(),
        openingTime: item['Opening_time'] ?? '00:00',
        closingTime: item['Closing_time'] ?? '23:59',
        distance: (item['Distance'] ?? 0).toInt(),
        deliveryFee: item['Delivery_Fee'] ?? 'N/A',
        promoCode: item['PromoCode'] ?? [],
        imageUrl: item['Image'] ?? '',
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantDetailsPage(restaurant: restaurant),
        ),
      );
    } catch (e) {
      // Handle errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to navigate: $e')),
      );
    }
  }
}

