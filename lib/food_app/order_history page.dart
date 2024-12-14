
import 'package:broadway/food_app/rating/shop_rating.dart';
import 'package:broadway/food_app/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';



import '../providerss/app_provider.dart'; // Adjust import as needed

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();

    final provider = Provider.of<MainProvider>(context, listen: false);
    provider.fetchOrderHistory();
    provider.fetchOngoingOrders();

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: const BoxDecoration(

                ),
                child: Column(
                  children: [


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
                    Consumer<MainProvider>(
                      builder: (context, provider, child) {
                        if (provider.isOngoingOrdersLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (provider.ongoingOrdersErrorMessage.isNotEmpty) {
                          return Center(
                            child: Text(
                              provider.ongoingOrdersErrorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (provider.ongoingOrders.isEmpty) {
                          return const Center(child: Text('No ongoing orders '));
                        }

                        return ListView.builder(
                          itemCount: provider.ongoingOrders.length,
                          itemBuilder: (context, index) {
                            return OrderListItem(
                                order: provider.ongoingOrders[index],
                                isOngoingOrder: true  // Add this line
                            );
                          },
                        );
                      },
                    ),
                    // History tab
                    Consumer<MainProvider>(
                      builder: (context, provider, child) {
                        if (provider.isOrderHistoryLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (provider.orderHistoryErrorMessage.isNotEmpty) {
                          return Center(
                            child: Text(
                              provider.orderHistoryErrorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (provider.orderHistory.isEmpty) {
                          return const Center(child: Text('No order history found'));
                        }

                        return ListView.builder(
                          itemCount: provider.orderHistory.length,
                          itemBuilder: (context, index) {
                            return OrderListItem(order: provider.orderHistory[index]);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final OrderHistoryItem order;
  final bool isOngoingOrder;

  const OrderListItem({
    Key? key,
    required this.order,
    this.isOngoingOrder = false
  }) : super(key: key);

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
                Text(order.itemName, style: const TextStyle(color: Colors.grey,fontSize: 12)),
                 SizedBox(width: 10),
                Text(order.status,
                    style: TextStyle(
                        color: _getStatusColor(order.status),fontSize: 12)),
                const Spacer(),
                Text(
                  DateFormat('yyyy-MM-dd').format(order.dateTime),
                  style: const TextStyle(color: Colors.grey,fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: ClipRRect(
                      borderRadius:BorderRadius.circular(20),
                      child: Image.network(order.restaurantDetails.image)
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.restaurantDetails.restaurantName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(order.restaurantDetails.place,
                          style: const TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          Text('\$${order.totalPrice.toStringAsFixed(2)}',
                              style:
                              const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          Text('${order.quantity} items',
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (isOngoingOrder)
              MaterialButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {

                  final provider = Provider.of<MainProvider>(context, listen: false);
                  provider.cancelOrder(context, order.id);
                },
                child: const Text('Cancel Order',
                    style: TextStyle(color: Colors.white)),
              ),
            if (!isOngoingOrder)
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
                              builder: (context) => ShopRatingPage(restaurantId: order.restaurantDetails.id,),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'order accepted':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}