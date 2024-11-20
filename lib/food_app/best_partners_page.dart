import 'package:broadway/food_app/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providerss/app_provider.dart';
import 'food_details_page.dart';
class BestPartnersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, loginProvider, _) =>
            _buildBestPartnersSection(context, loginProvider),
      ),
    );
  }

  Widget _buildBestPartnersSection(BuildContext context, LoginProvider loginProvider) {
    return FutureBuilder<List<Restaurant>>(
      future: loginProvider.fetchRestaurants(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final restaurants = snapshot.data!;
          print('Received ${restaurants.length} restaurants from API');
          return Container(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                          'Best Partners',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BestPartnersPage(),
                                )
                            );
                          },
                          child: const Text('See all')
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.215,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];
                        print('Displaying restaurant: ${restaurant.restaurantName}');
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RestaurantDetailsPage(restaurant: restaurant),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              margin: const EdgeInsets.only(right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: restaurant.imageUrl != null
                                            ? Image.network(
                                          restaurant.imageUrl!,
                                          height: MediaQuery.of(context).size.height * 0.135,
                                          width: MediaQuery.of(context).size.width * 0.64,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/placeholder.png',
                                              height: MediaQuery.of(context).size.height * 0.135,
                                              width: MediaQuery.of(context).size.width * 0.64,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                            : Image.asset(
                                          'assets/placeholder.png',
                                          height: MediaQuery.of(context).size.height * 0.135,
                                          width: MediaQuery.of(context).size.width * 0.64,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // Positioned(
                                      //   top: 8,
                                      //   right: 8,
                                      //   child: Container(
                                      //     padding: const EdgeInsets.symmetric(
                                      //       horizontal: 8,
                                      //       vertical: 4,
                                      //     ),
                                      //     decoration: BoxDecoration(
                                      //       color: restaurant.isOpen
                                      //           ? Colors.green.withOpacity(0.9)
                                      //           : Colors.red.withOpacity(0.9),
                                      //       borderRadius: BorderRadius.circular(4),
                                      //     ),
                                      //     child: Text(
                                      //       restaurant.isOpen ? 'Open' : 'Closed',
                                      //       style: const TextStyle(
                                      //         color: Colors.white,
                                      //         fontSize: 12,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),

                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    restaurant.restaurantName,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: restaurant.isOpen ? "Open" : "Closed",
                                          style: TextStyle(
                                            color: restaurant.isOpen ? Colors.green : Colors.red,
                                            fontWeight: FontWeight.bold, // Optional emphasis
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' - ${restaurant.place}, ${restaurant.district}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),


                                  Row(
                                    children: [
                                      const Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 16
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${restaurant.averageRating ?? 'N/A'} · ${restaurant.distance} km · ${restaurant.deliveryFee}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 12),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print('Error fetching restaurants: ${snapshot.error}');
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          print('Loading restaurants...');
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}