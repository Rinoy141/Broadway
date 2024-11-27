import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providerss/app_provider.dart';
import 'food_details_page.dart';


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
            return const Center(
              child: Text(
                'Start searching for restaurants or dishes',
                style: TextStyle(color: Colors.grey),
              ),
            );
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
              final isMenuItem = item.containsKey('Item');
              final isRestaurant = item.containsKey('Restaurant_Name') && !isMenuItem;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: _buildLeadingImage(item, isMenuItem, isRestaurant),
                  title: Text(
                    isMenuItem
                        ? '${item['Item'] ?? 'Unknown'} (${item['Restaurant_Name'] ?? 'Unknown Restaurant'})'
                        : item['Restaurant_Name'] ?? 'Unknown',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: _buildSubtitle(item, isMenuItem, isRestaurant),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                  onTap: () => _navigateToRestaurantDetails(context, mainProvider, item, isMenuItem),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSubtitle(dynamic item, bool isMenuItem, bool isRestaurant) {
    if (isMenuItem) {
      return Text(
        '${item['Category'] ?? ''} • \₹${item['Price'] ?? ''}',
        style: const TextStyle(color: Colors.grey),
      );
    } else if (isRestaurant) {
      return Text(
        '${item['Place'] ?? ''} • ${item['Distance'] != null ? '${item['Distance']} km' : ''}',
        style: const TextStyle(color: Colors.grey),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildLeadingImage(dynamic item, bool isMenuItem, bool isRestaurant) {
    String? imageUrl;

    if (isMenuItem) {
      imageUrl = item['Image'] as String?;
    } else if (isRestaurant) {
      imageUrl = item['ImageUrl'] as String?;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl != null
          ? Image.network(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderIcon(context, isMenuItem, isRestaurant);
        },
      )
          : _buildPlaceholderIcon(context, isMenuItem, isRestaurant),
    );
  }

  Widget _buildPlaceholderIcon(BuildContext context, bool isMenuItem, bool isRestaurant) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        isMenuItem ? Icons.fastfood : Icons.restaurant,
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
    );
  }

  void _navigateToRestaurantDetails(
      BuildContext context,
      MainProvider mainProvider,
      dynamic item,
      bool isMenuItem
      ) {
    int? restaurantId;

    if (isMenuItem) {
      restaurantId = item['Restaurant'] as int?;
    } else {
      restaurantId = item['id'] as int?;
    }

    if (restaurantId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantDetailsPage(restaurantId: restaurantId!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to find restaurant details')),
      );
    }
  }
}