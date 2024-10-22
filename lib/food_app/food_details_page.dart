
import 'package:broadway/food_app/restaurant_model.dart';
import 'package:broadway/food_app/size_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'food_provider.dart';



class DetailsPage extends StatelessWidget {
  final int restaurantIndex;

  const DetailsPage({super.key, required this.restaurantIndex});

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final restaurant = restaurantProvider.restaurants[restaurantIndex];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(context, restaurant),
            tabSection(context,restaurant),
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context, Restaurant restaurant) {
    return Stack(
      children: [
        // Restaurant Image
        Container(
          height: MediaQuery.of(context).size.height * 0.3, // Adjust as needed
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(restaurant.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Overlay gradient for better text visibility
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
        // Header content
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
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Take Away',
                        style: TextStyle(color: Colors.orange[800]),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.orange,
                        ))
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Open ',
                      style: TextStyle(color: Colors.green),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('•  ${restaurant.location}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text('${restaurant.rating}'),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time_filled_sharp,
                        size: 16, color: Colors.grey),
                    Text(restaurant.deliveryTime),
                    const SizedBox(width: 16),
                    const Icon(Icons.monetization_on_outlined,
                        size: 16, color: Colors.grey),
                    const Text('Free shipping'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Save \$15.00 with code Total Dish'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget tabSection(BuildContext context,Restaurant restaurant) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Delivery'),
              Tab(text: 'Review'),
            ],
          ),
          SizedBox(
            height: 500,
            child: TabBarView(
              children: [
                deliveryTab(context,restaurant), // Delivery tab shows popular items only
                reviewTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveryTab(BuildContext context, Restaurant restaurant) {
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
          // Horizontal List for popular items
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: InkWell(onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomizationPage(),));
            },
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurant.popularItems?.length,
                itemBuilder: (context, index) {
                  return InkWell(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomizationPage(
                          popularItem: restaurant.popularItems![index], // Pass PopularItem
                        ),
                      ),
                    );
                  } ,child: popularItemSection(restaurant.popularItems![index],context));
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
      
          // Loop through the food categories (Hot Burger Combo, Fried Chicken, etc.)
          for (var category in restaurant.foodCategories) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                category.name,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), 
              itemCount: category.items.length,
              itemBuilder: (context, index) {
                return InkWell(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomizationPage(
                        item: category.items[index], // Pass regular item
                      ),
                    ),
                  );
                },child: foodItemSection(category.items[index]));
              },
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget popularItemSection(PopularItem item, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.4,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(item.imageUrl),
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
              Text('\$${item.price.toStringAsFixed(2)} ',style: TextStyle(color: Colors.green),),
              Text('• ${item.category}')
            ],
          ),
        ],
      ),
    );
  }

// Widget for displaying each food item in the "Hot Burger Combo" and "Fried Chicken" sections
  Widget foodItemSection(Item item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Image of the food item
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Food details
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
                  '\$${item.prices['M']?.toStringAsFixed(2) ?? 'N/A'}',
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




  Widget reviewTab() {
    return const Center(
      child: Text('Reviews coming soon!'),
    );
  }
}
