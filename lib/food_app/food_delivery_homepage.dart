
import 'dart:math';

import 'package:broadway/food_app/nearby.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'best_partners_page.dart';
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
                        BestPartnersPage(),

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
                NearbyRestaurantsWidget(),
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



  Widget _buildSalesSection() {
    return const Center(child: Text('Sales Section'));
  }

  Widget _buildRateSection() {
    return const Center(child: Text('Rate Section'));
  }

  Widget _buildFastSection() {
    return const Center(child: Text('Fast Section'));
  }

