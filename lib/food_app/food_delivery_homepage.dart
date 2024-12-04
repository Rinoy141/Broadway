
import 'dart:math';
import 'dart:ui';
import 'package:broadway/food_app/confirm_order_page.dart';
import 'package:broadway/food_app/nearby.dart';
import 'package:broadway/food_app/order_history%20page.dart';
import 'package:broadway/food_app/popular_restaurants.dart';
import 'package:broadway/food_app/recommended_restaurants.dart';
import 'package:broadway/food_app/restaurant_model.dart';
import 'package:broadway/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerss/app_provider.dart';
import 'appbar.dart';
import 'best_partners_page.dart';
import 'category.dart';
import 'food_details_page.dart';
import 'food_provider.dart';

class FoodDeliveryHomePage extends StatelessWidget {
  const FoodDeliveryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppBarState(),
      child: Scaffold(
        body: Stack(children: [
          _buildBackgroundDesign(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                       children: [CustomAppBarContent(),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: _buildCategorySection(),
                        ),
                         _buildBestPartnersSection(context ,MainProvider()),

                        _buildTabSection(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildBackgroundDesign() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 350,
            height: 475,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffD9E4FF), // Very light blue with opacity
            ),
          ),
        ),
        Positioned(
          top: -20,
          right: -10,
          child: Transform.rotate(
            angle: 1 * (pi / 180), // Rotate by 45 degrees (in radians)
            child: Image.asset('Assets/bubble 2.png'),
          ),
        )
      ],
    );
  }

  Widget _buildCategorySection() {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        // Ensure fetchCategories() is only called once after the first build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (provider.categories.isEmpty && !provider.isLoadingCategories) {
            provider.fetchCategories();
          }
        });

        return Card(
          color: Colors.white,
          elevation: 10,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                        );
                      },
                      child: const Text('See All'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: provider.isLoadingCategories || provider.categories.isEmpty
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.categories.length,
                    itemBuilder: (context, index) {
                      final category = provider.categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MenuPage(categoryId: category.id),
                                  ),
                                );
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue[50],
                                ),
                                child: ClipOval(
                                  child: category.imageUrl.isNotEmpty
                                      ? Image.network(
                                    category.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.error_outline),
                                      );
                                    },
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  )
                                      : const Icon(Icons.restaurant_menu),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category.categoryName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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




  Widget _buildTabSection(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const TabBar(
              isScrollable: false,
              tabs: [
                Tab(text: 'Nearby'),
                Tab(text: 'Recommended'),
                Tab(text: 'Popular'),

              ],
            ),
          ),
          SizedBox(
            height: 300, // Adjust the height to fit your content
            child: TabBarView(
              children: [
                NearbyRestaurantsWidget(),
               RecommendedRestaurantsWidget(),
                MostPopularRestaurantsWidget(),

              ],
            ),
          ),
        ],
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
                                const SizedBox(height: 7),
                                Text(
                                  restaurant.restaurantName,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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






