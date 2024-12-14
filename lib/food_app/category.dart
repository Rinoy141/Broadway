import 'package:broadway/food_app/state%20providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:broadway/food_app/food_details_page.dart';


class MenuPage extends StatelessWidget {
  final int categoryId;

  const MenuPage({required this.categoryId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuProvider()..fetchMenuItems(categoryId),
      child: Consumer<MenuProvider>(
        builder: (context, menuProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Menu'),
            ),
            body: menuProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : menuProvider.menuItems.isEmpty
                ? const Center(child: Text('No menu items available.'))
                : ListView.builder(
              itemCount: menuProvider.menuItems.length,
              itemBuilder: (context, index) {
                final item = menuProvider.menuItems[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailsPage(
                          restaurantId: item.restaurantId,
                        ),
                      ),
                    );
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.fill,
                      width: 100,
                      height: 70,
                    ),
                  ),
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
