import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerss/app_provider.dart';


import 'food_details_page.dart';
import 'restaurant_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (query) {
            context.read<MainProvider>().searchMenuAndRestaurants(query);
          },
          decoration: const InputDecoration(
            hintText: 'Search restaurants or dishes...',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              context.read<MainProvider>().searchMenuAndRestaurants('');
            },
          ),
        ],
      ),
      body: Consumer<MainProvider>(
        builder: (context, mainProvider, child) {
          // Handle different search states
          if (mainProvider.currentSearchResults == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final searchResults = mainProvider.currentSearchResults ?? [];

          if (searchResults.isEmpty) {
            return const Center(
              child: Text('No results found'),
            );
          }

          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final item = searchResults[index];

              // Determine if it's a menu item or a restaurant
              final isMenuItem = item['Item'] != null;
              final isRestaurant = item['Restaurant_Name'] != null;

              return ListTile(
                leading: _buildLeadingImage(item, isMenuItem, isRestaurant),
                title: Text(
                  isMenuItem
                      ? '${item['Item'] ?? 'Unknown'} (${item['Restaurant_Name'] ?? 'Unknown Restaurant'})'
                      : item['Restaurant_Name'] ?? 'Unknown',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  isMenuItem
                      ? '${item['Category'] ?? ''} • \₹${item['Price'] ?? ''}'
                      : '${item['District'] ?? ''} ${item['Place'] != null ? '• ${item['Place']}' : ''}',
                ),
                onTap: () => _navigateToRestaurantDetails(context, mainProvider, item, isMenuItem),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLeadingImage(dynamic item, bool isMenuItem, bool isRestaurant) {
    String? imageUrl;

    if (isMenuItem) {
      imageUrl = item['Image'] as String?;
    } else if (isRestaurant) {
      imageUrl = item['ImageUrl'] as String?;
    }

    return imageUrl != null
        ? Image.network(
      imageUrl,
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
    );
  }

  void _navigateToRestaurantDetails(
      BuildContext context,
      MainProvider mainProvider,
      dynamic item,
      bool isMenuItem
      ) {
    int? restaurantId;

    // Extract restaurant ID based on the type of item
    if (isMenuItem) {
      // For menu items, use the 'Restaurant' field which contains the restaurant ID
      restaurantId = item['Restaurant'] as int?;
    } else {
      // For restaurant items, use the 'id' field
      restaurantId = item['id'] as int?;
    }

    // Ensure restaurant ID is not null before navigating
    if (restaurantId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantDetailsPage(restaurantId: restaurantId!),
        ),
      );
    } else {
      // Optional: Show an error message if no restaurant ID is found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to find restaurant details')),
      );
    }
  }
}