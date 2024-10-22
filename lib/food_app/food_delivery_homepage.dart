import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appbar.dart';
import 'best_partners_page.dart';
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
                        _buildBestPartnersSection(context),
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
    final categories = [
      {'icon': Icons.local_pizza, 'name': 'Sandwich'},
      {'icon': Icons.coffee, 'name': 'Pizza'},
      {'icon': Icons.fastfood, 'name': 'Burgers'},
    ];

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
                const Text('Category',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('See all')),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            print(
                                '${categories[index]['name']} button pressed!');
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue[50],
                            child: Icon(categories[index]['icon'] as IconData),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(categories[index]['name'] as String),
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
  }

  Widget _buildBestPartnersSection(BuildContext context) {
    var restaurantProvider = Provider.of<RestaurantProvider>(context);
    var restaurants = restaurantProvider.restaurants;

    return Container(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Best Partners',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BestPartnersPage(),
                          ));
                    },
                    child: const Text('See all')),
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
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(restaurantIndex: index),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              restaurant.image,
                              height:
                                  MediaQuery.of(context).size.height * 0.135,
                              width: MediaQuery.of(context).size.width * 0.64,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            restaurant.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSection(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const TabBar(
              isScrollable: false,
              tabs: [
                Tab(text: 'Nearby'),
                Tab(text: 'Sales'),
                Tab(text: 'Rate'),
                Tab(text: 'Fast'),
              ],
            ),
          ),
          SizedBox(
            height: 300, // Adjust the height to fit your content
            child: TabBarView(
              children: [
                _buildNearbySection(context),
                _buildSalesSection(),
                _buildRateSection(),
                _buildFastSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbySection(BuildContext context) {
    var restaurantProvider = Provider.of<RestaurantProvider>(context);
    var restaurants = restaurantProvider.restaurants;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
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
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 16),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              restaurant.image,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                restaurant.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.verified,
                                  color: Colors.green, size: 16),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${restaurant.isOpen ? 'Open' : 'Closed'} · ${restaurant.location}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.orange, size: 16),
                              const SizedBox(width: 4),
                              Text('${restaurant.rating}'),
                              const SizedBox(width: 8),
                              const Icon(Icons.location_on,
                                  color: Colors.grey, size: 16),
                              const SizedBox(width: 4),
                              Text(restaurant.distance),
                              const SizedBox(width: 8),
                              const Icon(Icons.local_shipping,
                                  color: Colors.grey, size: 16),
                              const SizedBox(width: 4),
                              const Text('Free shipping'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSalesSection() {
    return const Center(child: Text('Sales Section'));
  }

  Widget _buildRateSection() {
    return const Center(child: Text('Rate Section'));
  }

  Widget _buildFastSection() {
    return const Center(child: Text('Fast Section'));
  }
}
