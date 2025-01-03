
import 'package:broadway/common/colors.dart';
import 'dart:ui';
import 'package:broadway/common/images.dart';
import 'package:flutter/material.dart';
// import '../../../broadway/lib/common/colors.dart';
// import '../../../broadway/lib/common/images.dart';

class AddToCartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const AddToCartPage({super.key, required this.cartItems});

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}
class _AddToCartPageState extends State<AddToCartPage> {
  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          // Top Section
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Stack(
                  children: [
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.40,
                      child: Image.asset(
                        theImages.sideview,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.69,
                      bottom: MediaQuery.of(context).size.height * 0.18,
                      child: Image.asset(
                        theImages.sideview2,
                        height: MediaQuery.of(context).size.height * 0.36,
                        width: MediaQuery.of(context).size.width * 0.36,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.1),
                      topRight: Radius.circular(MediaQuery.of(context).size.height * 0.1),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Items",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add place order functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: thecolors.blow2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: const Text(
                            'order confirmed',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Cart Items Section
          Expanded(
            child: Container(
              color: thecolors.primaryColor,
              child: widget.cartItems.isEmpty
                  ? const Center(
                child: Text(
                  "No items in the cart",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  var item = widget.cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(item['name']),
                        subtitle: Text("₹${item['price']} x ${item['count']}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeItem(index),
                        ),
                        // Uncomment the line below if you want to show an image
                        leading: Image.network(item['image']),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
