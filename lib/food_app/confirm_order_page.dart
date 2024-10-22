import 'package:broadway/food_app/restaurant_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'food_provider.dart';

class ConfirmOrderPage extends StatelessWidget {
  final PopularItem? popularItem;
  final Item? item;
  final double price;
  final int quantity;

  const ConfirmOrderPage({
    Key? key,
    this.popularItem,
    this.item,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Confirm Order'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeliverySection(context),
              const SizedBox(height: 20),
              _buildRestaurantSection(context),
              const SizedBox(height: 20),
              _buildVoucherContainer(),
              const SizedBox(height: 20),
              _buildPaymentOptions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeliverySection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        boxShadow: [
          BoxShadow(
              spreadRadius: 5, blurRadius: 10, color: Colors.grey.shade300)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Delivery to',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.location_on, color: Colors.green),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Text('1.5 km', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantSection(BuildContext context) {
    final name = popularItem?.name ?? item?.name ?? '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              spreadRadius: 5, blurRadius: 10, color: Colors.grey.shade300),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildOrderItem(context),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context) {
    final restaurantProvider = context.watch<RestaurantProvider>();
    final name = popularItem?.name ?? item?.name ?? '';
    final imageUrl = popularItem?.imageUrl ?? item?.imageUrl ?? '';
    final price = popularItem != null
        ? popularItem!.price
        : item?.prices[restaurantProvider.selectedSize] ?? 0.0;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(imageUrl, fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffC1C7D0)),
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                  onPressed: () =>
                                      restaurantProvider.updateQuantity(-1),
                                ),
                              ),
                              Text('${restaurantProvider.quantity}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffC1C7D0)),
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                  onPressed: () =>
                                      restaurantProvider.updateQuantity(1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                            '\$${(price * restaurantProvider.quantity).toStringAsFixed(2)}',
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _buildSummaryRow(context),
      ],
    );
  }

  Widget _buildSummaryRow(BuildContext context) {
    final restaurantProvider = context.watch<RestaurantProvider>();
    final price = popularItem != null
        ? popularItem!.price
        : item?.prices[restaurantProvider.selectedSize] ?? 0.0;

    return Column(
      children: [
        _buildSummaryDetail('Subtotal',
            '\$${(price * restaurantProvider.quantity).toStringAsFixed(2)}'),
        _buildSummaryDetail('Delivery', '\$0.00'),
        _buildSummaryDetail('Voucher', '-'),
        const Divider(),
        _buildSummaryDetail('Total',
            '\$${(price * restaurantProvider.quantity).toStringAsFixed(2)}',
            isTotal: true),
      ],
    );
  }

  Widget _buildSummaryDetail(String label, String value,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildVoucherContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              spreadRadius: 5, blurRadius: 10, color: Colors.grey.shade300),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.percent, color: Colors.orange),
          const SizedBox(width: 8),
          const Text('Add Voucher'),
          const Spacer(),
          TextButton(
            onPressed: () {
              // Handle adding voucher
            },
            child: const Text('Add', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions(BuildContext context) {
    final restaurantProvider = context.watch<RestaurantProvider>();
    final price = popularItem != null
        ? popularItem!.price
        : item?.prices[restaurantProvider.selectedSize] ?? 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              spreadRadius: 5, blurRadius: 10, color: Colors.grey.shade300),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _showPaymentBottomSheet(context),
                child: _buildPaymentOption('Paypal',
                    '\$${(price * restaurantProvider.quantity).toStringAsFixed(2)}'),
              ),
              _buildPaymentOption('Cash',
                  '\$${(price * restaurantProvider.quantity).toStringAsFixed(2)}',
                  isSelected: true),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Icon(
                        CupertinoIcons.check_mark_circled,
                        color: Colors.green,
                      ),
                      content: Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('You ordered successfully',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          Text(
                              'You successfully place an order, your order is confirmed and delivered within 20 minutes. Wish you enjoy the food',style: TextStyle(color: Colors.grey[600]),textAlign: TextAlign.center,)
                        ],
                      ),
                      actions: <Widget>[
                        Center(
                          child: TextButton(
                            child: const Text('KEEP BROWSING',style: TextStyle(fontWeight: FontWeight.w700,color: Color(0xff004CFF)),),
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Navigate back to the main page or wherever you want
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff004BFE),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child:
                  const Text('Submit', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method, String amount,
      {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[50] : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: isSelected ? Colors.blue : Colors.transparent),
      ),
      child: Column(
        children: [
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(method,
              style: TextStyle(color: isSelected ? Colors.blue : Colors.grey)),
        ],
      ),
    );
  }

  void _showPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.5,
          expand: false,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Add your payment methods',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: Colors.grey[500],
                        ),
                        hintText: '0000 - 0000 - 0000 - 0000',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'MM/YY',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                            ),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'CVC',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle adding card
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff004BFE),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Add Card',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('confirm',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
