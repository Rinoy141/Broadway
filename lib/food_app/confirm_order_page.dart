import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:broadway/providerss/app_provider.dart';
import 'package:broadway/food_app/restaurant_model.dart';
import 'package:broadway/food_app/confirm_order_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MainProvider>(context, listen: false).fetchCartItems();
      Provider.of<MainProvider>(context, listen: false).fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<MainProvider>(
        builder: (context, cartProvider, child) {
          // Loading state
          if (cartProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (cartProvider.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  Text('Error: ${cartProvider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => cartProvider.fetchCartItems(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Empty cart state
          if (cartProvider.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fastfood_outlined),
                  const SizedBox(height: 16),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Looks like you haven\'t added anything to your cart yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          Widget _buildDeliverySection(BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.13,
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  const SizedBox(height: 10),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${cartProvider.userProfile?.address}',
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

          Widget _cartitemslist(){
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartProvider.cartItems[index];
                  final onQuantityChanged = (int newQuantity) {
                    if (newQuantity > 0) {
                      cartProvider.updateCartItemQuantity(cartItem.id, newQuantity);
                    } else {
                      cartProvider.removeCartItem(cartItem.id);
                    }
                  };
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
                              child: Image.network(cartItem.menuItems.image, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartItem.itemName,
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
                                                onPressed: () => onQuantityChanged(cartItem.quantity - 1),
                                              ),
                                            ),
                                            Text('${cartItem.quantity}',
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
                                                onPressed: () => onQuantityChanged(cartItem.quantity + 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }

          Widget _buildRestaurantSection(BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 5,
                      color: Colors.grey.shade300
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Restaurant',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 10),

                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartProvider.cartItems[index];
                        final onQuantityChanged = (int newQuantity) {
                          if (newQuantity > 0) {
                            cartProvider.updateCartItemQuantity(cartItem.id, newQuantity);
                          } else {
                            cartProvider.removeCartItem(cartItem.id);
                          }
                        };
                        return Padding(
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
                                child: Image.network(cartItem.menuItems.image, fit: BoxFit.cover),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        cartItem.itemName,
                                        style: const TextStyle(fontWeight: FontWeight.bold)
                                    ),
                                    const SizedBox(height: 5),
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
                                                    color: Color(0xffC1C7D0)
                                                ),
                                                height: 30,
                                                width: 30,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () => onQuantityChanged(cartItem.quantity - 1),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Text(
                                                    '${cartItem.quantity}',
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16
                                                    )
                                                ),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffC1C7D0)
                                                ),
                                                height: 30,
                                                width: 30,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () => onQuantityChanged(cartItem.quantity + 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(), // Add price on the right side
                                        Text(
                                            '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                            )
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Order Summary Section
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSummaryRow('Subtotal', '\$${cartProvider.totalPrice.toStringAsFixed(2)}'),
                        _buildSummaryRow('Delivery Charge', '\$${cartProvider.cartItems.first.deliveryCharge.toStringAsFixed(2)}'),
                        _buildSummaryRow('Tax', '\$${(cartProvider.totalPrice * 0.1).toStringAsFixed(2)}'),
                        const Divider(),
                        _buildSummaryRow('Total', '\$${(cartProvider.totalPrice + cartProvider.cartItems.first.deliveryCharge + (cartProvider.totalPrice * 0.1)).toStringAsFixed(2)}', isBold: true),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            //place order
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff004BFE),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // Main build method now simplified
          return Column(
            children: [
              _buildDeliverySection(context),
              const SizedBox(height: 10),
              _buildRestaurantSection(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.black : Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}