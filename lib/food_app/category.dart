import 'package:broadway/food_app/food_details_page.dart';
import 'package:broadway/food_app/restaurant_model.dart';
import 'package:broadway/providerss/app_provider.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  final int categoryId;

  MenuPage({required this.categoryId});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _menuApiProvider = MainProvider();
  List<MenuItem> _menuItems = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMenuItems();
  }

  Future<void> _fetchMenuItems() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _menuItems =
          await _menuApiProvider.getMenuItemsByCategory(widget.categoryId);
    } catch (e) {
      // Handle error
      print('Error fetching menu items: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailsPage(
                              restaurantId: item.restaurantId),
                        ));
                  },
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.fill,
                        width: 100,
                        height: 70,
                      )),
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                );
              },
            ),
    );
  }
}
