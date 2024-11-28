import 'package:broadway/providerss/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String selectedPaymentMethod = 'Online Payment';

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
        title: const Text('My Cart',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
                      spreadRadius: 5,
                      blurRadius: 10,
                      color: Colors.grey.shade300)
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Delivery to',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                        child:
                            const Icon(Icons.location_on, color: Colors.green),
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
                      color: Colors.grey.shade300),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Restaurant',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
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
                            cartProvider.updateCartItemQuantity(
                                cartItem.id, newQuantity);
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
                                child: Image.network(cartItem.menuItems.image,
                                    fit: BoxFit.cover),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(cartItem.itemName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffC1C7D0)),
                                                height: 30,
                                                width: 30,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () =>
                                                      onQuantityChanged(
                                                          cartItem.quantity -
                                                              1),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                    '${cartItem.quantity}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16)),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffC1C7D0)),
                                                height: 30,
                                                width: 30,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () =>
                                                      onQuantityChanged(
                                                          cartItem.quantity +
                                                              1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                            '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16))
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
                        _buildSummaryRow('Subtotal',
                            '\$${cartProvider.cartItems.first.totalPrice.toStringAsFixed(2)}'),
                        _buildSummaryRow('Delivery Charge',
                            '\$${cartProvider.cartItems.first.deliveryCharge.toStringAsFixed(2)}'),
                        _buildSummaryRow('Offer Price',
                            '\$${(cartProvider.cartItems.first.offerPrice * 0.1).toStringAsFixed(2)}'),
                        const Divider(),
                        _buildSummaryRow('Total',
                            '\$${(cartProvider.cartItems.first.totalPrice.toStringAsFixed(2))}',
                            isBold: true),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // Main build method
          return Column(
            children: [
              _buildDeliverySection(context),
              const SizedBox(height: 10),
              _buildRestaurantSection(context),
              const SizedBox(height: 10),
              _buildVoucherContainer(context),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _paymentOption('Online Payment', Icons.payment,
                        '\$${(cartProvider.cartItems.first.totalPrice.toStringAsFixed(2))}'),
                    _paymentOption('Cash', Icons.attach_money,
                        '\$${(cartProvider.cartItems.first.totalPrice.toStringAsFixed(2))}'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (cartProvider.cartItems.isNotEmpty) {
                    cartProvider.placeOrder(
                        context,
                        selectedPaymentMethod == 'Online Payment'
                            ? 'online_payment'
                            : 'cash_on_delivery');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Your cart is empty')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff004BFE),
                  padding: EdgeInsets.symmetric(horizontal: 120),
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

  Widget _buildVoucherContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 10,
            color: Colors.grey.shade300,
          ),
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
              _showVoucherDialog(
                  context, Provider.of<MainProvider>(context, listen: false));
            },
            child: const Text('Add', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Widget _paymentOption(String title, IconData icon, String amount) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedPaymentMethod = title;
          });
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: selectedPaymentMethod == title
                ? Colors.blue.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: selectedPaymentMethod == title
                  ? Colors.blue
                  : Colors.grey.shade300,
              width: 2.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: selectedPaymentMethod == title
                      ? Colors.blue
                      : Colors.grey),
              SizedBox(height: 8.0),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              Text(amount,
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

void _showVoucherDialog(BuildContext context, MainProvider provider) {
  final TextEditingController voucherController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter Voucher Code'),
        content: TextField(
          controller: voucherController,
          decoration: const InputDecoration(
            hintText: 'Enter your voucher code',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final voucherCode = voucherController.text.trim();
              if (voucherCode.isNotEmpty) {
                provider.applyPromoCode(context, voucherCode); // Call the API
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a voucher code.')),
                );
              }
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
