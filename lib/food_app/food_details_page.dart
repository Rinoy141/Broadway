import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providerss/app_provider.dart';
import 'restaurant_model.dart';



class RestaurantDetailsPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailsPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  _RestaurantDetailsPageState createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginProvider>(context, listen: false)
          .fetchRestaurantMenu(widget.restaurant.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                _buildTabSection(context, provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.restaurant.imageUrl ?? 'placeholder_url'),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
                      widget.restaurant.restaurantName,
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
                    Text('•  ${widget.restaurant.district}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text('${widget.restaurant.averageRating}'),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time_filled_sharp,
                        size: 16, color: Colors.grey),
                    Text(widget.restaurant.distance.toString()),
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

  Widget _buildTabSection(BuildContext context, LoginProvider provider) {
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
                _buildDeliveryTab(context, provider),
                _buildReviewTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryTab(BuildContext context, LoginProvider provider) {
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

  Widget _buildPopularItemsList(BuildContext context, List<PopularItem> popularItems) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularItems.length,
        itemBuilder: (context, index) {
          final item = popularItems[index];
          return InkWell(
            onTap: () {

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
              Text('\$${item.price.toStringAsFixed(2)} ', style: const TextStyle(color: Colors.green)),
              Text('• ${item.category}')
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCategories(BuildContext context, List<FoodCategory> categories) {
    return Column(
      children: categories.map((category) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                category.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.prices['default']?.toStringAsFixed(2) ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTab() {
    return const Center(
      child: Text('Reviews coming soon!'),
    );
  }
}