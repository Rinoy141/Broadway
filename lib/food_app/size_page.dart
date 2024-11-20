//
// import 'package:broadway/food_app/restaurant_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providerss/app_provider.dart';
// import 'confirm_order_page.dart';
// import 'food_provider.dart';
//
// class CustomizationPage extends StatelessWidget {
//   final PopularItem? popularItem;
//   final Item? item;
//
//   const CustomizationPage({
//     super.key,
//     this.popularItem,
//     this.item,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final restaurantProvider = context.watch<RestaurantProvider>();
//
//     final name = popularItem?.name ?? item?.name ?? '';
//     final description = popularItem?.category ?? item?.description ?? '';
//     final imageUrl = popularItem?.imageUrl ?? item?.imageUrl ?? '';
//
//     final price = popularItem != null
//         ? popularItem!.price
//         : item?.prices[restaurantProvider.selectedSize] ?? 0.0;
//
//     return Scaffold(
//       body: Column(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     name,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     description,
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 150),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.asset(
//                       imageUrl,
//                       width: double.infinity,
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   if (item != null)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: item!.prices.keys
//                           .map((size) => _buildSizeButton(context, size))
//                           .toList(),
//                     ),
//                   const SizedBox(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildQuantityButton(Icons.remove, () {
//                         restaurantProvider.updateQuantity(-1);
//                       }),
//                       const SizedBox(width: 24),
//                       Text('${restaurantProvider.quantity}'),
//                       const SizedBox(width: 24),
//                       _buildQuantityButton(Icons.add, () {
//                         restaurantProvider.updateQuantity(1);
//                       }),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 19),
//                     child: SizedBox(
//                       child: Row(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text('Price'),
//                               Text(
//                                 '\$${(price * restaurantProvider.quantity).toStringAsFixed(2)}',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Spacer(),
//                           ElevatedButton(
//                             onPressed: () {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text('Added to cart')),
//                               );
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) =>  ConfirmOrderPage( popularItem: popularItem,
//                                   item: item,
//                                   price: price,
//                                   quantity: restaurantProvider.quantity,)),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xff004CFF),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text('Add to Order',
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSizeButton(BuildContext context, String size) {
//     final restaurantProvider = context.watch<RestaurantProvider>();
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: ElevatedButton(
//         onPressed: () => restaurantProvider.setSelectedSize(size),
//         style: ElevatedButton.styleFrom(
//           foregroundColor: restaurantProvider.selectedSize == size
//               ? Colors.black
//               : Colors.black,
//           backgroundColor: restaurantProvider.selectedSize == size
//               ? const Color(0xffC7D6FB)
//               : Colors.white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           padding: const EdgeInsets.all(18),
//         ),
//         child: Text(size),
//       ),
//     );
//   }
//
//   Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           color: Color(0xffC7D6FB),
//         ),
//         child: Icon(icon, color: Colors.white),
//       ),
//     );
//   }
// }
