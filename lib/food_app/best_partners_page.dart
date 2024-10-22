
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'food_details_page.dart';
import 'food_provider.dart';
class BestPartnersPage extends StatelessWidget {
  const BestPartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final restaurants = restaurantProvider.restaurants;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Best Partners',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(restaurantIndex: index),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                restaurant.image,
                                height: 175,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              restaurant.name,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${restaurant.isOpen ? 'Open' : 'Closed'} · ${restaurant.location}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.orange, size: 16),
                                Text(
                                    '${restaurant.rating} · ${restaurant.distance} · Free shipping'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}