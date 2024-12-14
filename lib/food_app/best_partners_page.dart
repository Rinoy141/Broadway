import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:broadway/food_app/restaurant_model.dart';
import '../providerss/app_provider.dart';
import 'food_details_page.dart';

class BestPartnersPage extends StatelessWidget {
  const BestPartnersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Partners'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (_) => MainProvider(),
        child: Consumer<MainProvider>(
          builder: (context, mainProvider, _) =>
              _buildBestPartnersSection(context, mainProvider),
        ),
      ),
    );
  }

  Widget _buildBestPartnersSection(BuildContext context, MainProvider mainProvider) {
    return FutureBuilder<List<BestSeller>>(
      future: mainProvider.fetchBestSellers(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final restaurants = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];

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
                          child:
                           Container(
                            width: MediaQuery.of(context).size.width * 1,

                            margin: const EdgeInsets.only(right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    restaurant.image,
                                    height: MediaQuery.of(context).size.height * 0.18,
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'Assets/images/Grocery Store.png',
                                        height: MediaQuery.of(context).size.height * 0.15,
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  restaurant.restaurantName,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                 const SizedBox(height: 6,),
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
                                const SizedBox(height: 6,),
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