import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providerss/app_provider.dart';
import 'food_details_page.dart';
class MostPopularRestaurantsWidget extends StatefulWidget {
  @override
  _MostPopularRestaurantsWidgetState createState() => _MostPopularRestaurantsWidgetState();
}

class _MostPopularRestaurantsWidgetState extends State<MostPopularRestaurantsWidget> {
  bool _hasFetchedInitially = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMostPopularRestaurantsIfNeeded();
    });
  }

  void _fetchMostPopularRestaurantsIfNeeded() {
    final loginProvider = Provider.of<MainProvider>(context, listen: false);
    if (!_hasFetchedInitially && loginProvider.mostPopularRestaurants.isEmpty) {
      loginProvider.fetchMostPopularRestaurants().then((_) {
        setState(() {
          _hasFetchedInitially = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, _) {
        if (mainProvider.isLoadingMostPopular) {
          return const Center(child: CircularProgressIndicator());
        }

        if (mainProvider.mostPopularRestaurants.isEmpty) {
          return const Center(
            child: Text('No popular restaurants found.'),
          );
        }

        return Container(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        'Most Popular Restaurants',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),

                  ],
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.22,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: mainProvider.mostPopularRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = mainProvider.mostPopularRestaurants[index];

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetailsPage(restaurantId: restaurant.id),
                              ),
                            );
                          },
                          child: Container(
                            width: 250,
                            margin: const EdgeInsets.only(right: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: restaurant.image.isNotEmpty
                                          ? Image.network(
                                        'https://broadway.icgedu.com${restaurant.image}',
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            'Assets/images/Grocery Store.png',
                                            height: 120,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                          : Image.asset(
                                        'assets/placeholder.png',
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: restaurant.status == 'Open'
                                              ? Colors.green.withOpacity(0.8)
                                              : Colors.red.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          restaurant.status,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  restaurant.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  restaurant.location,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        '${restaurant.rating} · ${restaurant.distance} km · Fee: ₹${restaurant.deliveryFee}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
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
      },
    );
  }
}