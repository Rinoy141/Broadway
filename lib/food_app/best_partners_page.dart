import 'package:broadway/food_app/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providerss/app_provider.dart';
import 'food_details_page.dart';

class BestPartnersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainProvider(),
      child: Consumer<MainProvider>(
        builder: (context, mainProvider, _) =>
            _buildBestPartnersSection(context, mainProvider),
      ),
    );
  }

  Widget _buildBestPartnersSection(BuildContext context, MainProvider mainProvider) {
    return FutureBuilder<List<BestSeller>>(
      future: mainProvider.fetchBestSellers(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final restaurants = snapshot.data!;
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
                        // Find the first active promo
                        BestSellerPromo? activePromo;
                        if (restaurant.bestSellers.isNotEmpty) {
                          final now = DateTime.now();
                          activePromo = restaurant.bestSellers.firstWhere(
                                (promo) => promo.startDate.isBefore(now) && promo.endDate.isAfter(now),
                            orElse: () => restaurant.bestSellers.first,
                          );
                        }

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RestaurantDetailsPage(restaurantId: restaurant.id)
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
                                        child: Image.network(
                                          restaurant.image,
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
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    restaurant.restaurantName,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: restaurant.status,
                                          style: TextStyle(
                                              color: restaurant.status.toLowerCase() == "open"
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' - ${restaurant.district}',
                                          style: const TextStyle(fontWeight:FontWeight.w600,
                                            fontSize: 15,
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
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${restaurant.rating} · ${restaurant.distance} km · Delivery fee ₹${ restaurant.deliveryFee}',
                                                style: const TextStyle(fontSize: 10,color: Colors.grey,fontWeight:FontWeight.w600,),
                                              ),
                                              if (activePromo != null) TextSpan(
                                                text: ' · ${activePromo.code} ${activePromo.value.toStringAsFixed(0)}% OFF',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          overflow: TextOverflow.ellipsis,
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
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}