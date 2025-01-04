
import 'package:flutter/material.dart';
import '../common/colors.dart';
import '../common/images.dart';
// import '../../../broadway4/lib/Buy_and sell/add_to_cart.dart';
import 'add_to_cart.dart';

class CartPage extends StatefulWidget {
  final String image;
  final String name;
  final String product;
  final String price;

  const CartPage({
    super.key,
    required this.image,
    required this.name,
    required this.product,
    required this.price,
  });
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int count = 1;
  late double basePrice;
  late double totalPrice;
  List<Map<String, dynamic>> cart = []; // List of products in the cart

  @override
  void initState() {
    super.initState();
    // Remove non-numeric characters from the price string
    String numericPrice = widget.price.replaceAll(RegExp(r'[^0-9.]'), '');
    basePrice = double.parse(numericPrice); // Parse the sanitized price
    totalPrice = basePrice; // Initialize total price
  }

  void addToCart() {
    setState(() {
      cart.add({
        'name': widget.name,
        'price': totalPrice.toStringAsFixed(2),
        'count': count,
        'image': widget.image,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.name} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              // Top Section
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
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
                      bottom: MediaQuery.of(context).size.height * 0.40,
                      child: Image.asset(
                        theImages.sideview2,
                        height: MediaQuery.of(context).size.height * 0.36,
                        width: MediaQuery.of(context).size.width * 0.36,
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom Section
              Positioned(
                top: MediaQuery.of(context).size.height * 0.18,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.99,
                  decoration: BoxDecoration(
                    // color: thecolors,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.1),
                      topRight: Radius.circular(MediaQuery.of(context).size.height * 0.1),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.1),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                // Image.network(
                                //   // widget.image,
                                //   height: MediaQuery.of(context).size.height * 0.1,
                                //   width: MediaQuery.of(context).size.width * 0.2,
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(context).size.width * 0.05,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "₹${totalPrice.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.06,
                                        // color: thecolors.darkbl,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (count > 1) {
                                          setState(() {
                                            count--;
                                            totalPrice = basePrice * count;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.remove),
                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.04,
                                      width: MediaQuery.of(context).size.width * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
                                      ),
                                      child: Center(
                                        child: Text(
                                          count.toString(),
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count++;
                                          totalPrice = basePrice * count;
                                        });
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                addToCart();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddToCartPage(
                                      cartItems: cart,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
                                  color: thecolors.blow2,
                                ),
                                child: Center(
                                  child: Text(
                                    'Place Order',
                                    style: TextStyle(color: thecolors.primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            // color: thecolors.darkbl,
          ),
        ],
      ),
    );
  }
}
