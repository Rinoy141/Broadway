import 'package:broadway/food_app/restaurant_model.dart';
import 'package:broadway/food_app/set_quantity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../providerss/app_provider.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final int restaurantId;

  const RestaurantDetailsPage({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MainProvider>();
      provider.fetchRestaurantDetails(widget.restaurantId);
      provider.fetchRestaurantMenu(widget.restaurantId);
      provider.fetchReviews(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.restaurantDetails == null) {
            return const Center(
              child: Text('Restaurant details not available'),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildHeader(context, provider.restaurantDetails!),
              ),
              SliverToBoxAdapter(
                child: _buildTabSection(context, provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Restaurant restaurant) {
    return Stack(
      children: [
        // Background Image
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(restaurant.imageUrl ?? 'placeholder_url'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gradient Overlay
        Container(
          height: MediaQuery.of(context).size.height * 0.38,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
        ),

        // Header Content
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      restaurant.restaurantName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Open ',
                      style: TextStyle(color: Colors.green),
                    ),
                    const SizedBox(width: 5),
                    Text('•  ${restaurant.district}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    Text(
                      restaurant.averageRating != null
                          ? restaurant.averageRating!
                              .toStringAsFixed(1) 
                          : 'N/A',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(width: 16),
                    const Icon(Icons.location_on, size: 16),
                    Text(
                      '${restaurant.distance} km',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.delivery_dining,
                      size: 20,
                    ),
                    Text(
                      ' Delivery fee \₹${restaurant.deliveryFee} ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                // Promo code section
                if (restaurant.promoCodes.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.discount_outlined,
                              color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'Save ₹${restaurant.promoCodes[0].value.toStringAsFixed(0)} with code ${restaurant.promoCodes[0].code}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection(BuildContext context, MainProvider provider) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            tabs: [
              Tab(
                text: 'Delivery',
              ),
              Tab(text: 'Review'),
            ],
          ),
          SizedBox(
            height: 500,
            child: TabBarView(
              children: [
                _buildDeliveryTab(context, provider),
                _buildReviewTab(provider),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryTab(BuildContext context, MainProvider provider) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Popular Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildPopularItemsList(context, provider.popularItems),
          _buildFoodCategories(context, provider.foodCategories),
        ],
      ),
    );
  }

  Widget _buildPopularItemsList(
      BuildContext context, List<PopularItem> popularItems) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularItems.length,
        itemBuilder: (context, index) {
          final item = popularItems[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomizationPage(popularItem: item),
                ),
              );
            },
            child: _buildPopularItemWidget(item, context),
          );
        },
      ),
    );
  }

  Widget _buildPopularItemWidget(PopularItem item, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text('\$${item.price.toStringAsFixed(2)} ',
                  style: const TextStyle(color: Colors.green)),
              Text('• ${item.category}')
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCategories(
      BuildContext context, List<FoodCategory> categories) {
    return Column(
      children: categories.map((category) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                category.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: category.items.length,
              itemBuilder: (context, index) {
                final item = category.items[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomizationPage(item: item),
                      ),
                    );
                  },
                  child: _buildFoodItemWidget(item),
                );
              },
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildFoodItemWidget(Item item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.prices['default']?.toStringAsFixed(2) ?? 'N/A'}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTab(MainProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.reviews.isEmpty) {
      return const Center(
        child: Text('No reviews available'),
      );
    }

    if (provider.error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error loading reviews', style: TextStyle(color: Colors.red)),
            Text(provider.error, style: TextStyle(color: Colors.grey)),
            ElevatedButton(
              onPressed: () => provider.fetchReviews(widget.restaurantId),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (provider.reviews.isEmpty) {
      return const Center(child: Text('No reviews yet'));
    }

    return ListView.builder(
      itemCount: provider.reviews.length,
      itemBuilder: (context, index) {
        final review = provider.reviews[index];
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('Assets/images/Ellipse 1 (4).png'),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.customerName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      RatingBar.builder(
                        initialRating: review.rating.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (_) {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      review.review,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
