import 'package:broadway/food_app/rating/driver_rating.dart';
import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  OrderHistoryPage({super.key});

  final List<Map<String, dynamic>> orders = [
    {
      'type': 'Drink',
      'status': 'Completed',
      'date': DateTime(2023, 3, 3),
      'restaurant': 'Starbucks',
      'address': 'thrissur',
      'price': 40.0,
      'itemCount': 2,
      'imageUrl': 'Assets/image 5.png',
    },
    {
      'type': 'Food',
      'status': 'Completed',
      'date': DateTime(2023, 3, 3),
      'restaurant': 'Burger King',
      'address': 'kochi',
      'price': 40.0,
      'itemCount': 2,
      'imageUrl': 'Assets/image 5.png',
    },
    {
      'type': 'Food',
      'status': 'Completed',
      'date': DateTime(2023, 3, 3),
      'restaurant': 'McDonald\'s',
      'address': '8700 kochi CA 90048',
      'price': 40.0,
      'itemCount': 2,
      'imageUrl': 'Assets/image 7.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Container(height: MediaQuery.of(context).size.height*0.22,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  ),
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
                    child: TextField(
                      decoration: InputDecoration(filled: true,fillColor: Colors.grey[200],
                        hintText: 'Search',hintStyle: TextStyle(color: Colors.grey[500]),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
                      ),
                    ),
                  ),const Spacer(),
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Color(0xff004BFE),
                    tabs: [
                      Tab(text: 'Ongoing'),
                      Tab(text: 'History'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Ongoing orders tab
                  const Center(child: Text('No ongoing orders')),
                  // History tab
                  ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return OrderListItem(order: orders[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(order['type'], style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 20),
                Text(order['status'],
                    style: const TextStyle(color: Colors.green)),
                const Spacer(),
                Text(order['date'].toString().split(' ')[0],
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.17,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: AssetImage(order['imageUrl']),
                        height: MediaQuery.of(context).size.height * 0.15,
                      )),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order['restaurant'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(order['address'],
                          style: const TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          Text('\$${order['price'].toStringAsFixed(2)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          Text('${order['itemCount']} items',
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DriverRatingPage(),
                          ));
                    },
                    child: const Text('Rate'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: MaterialButton(
                    color: const Color(0xff004CFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {},
                    child: const Text('Re-Order',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
