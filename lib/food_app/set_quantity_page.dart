// import 'package:broadway/food_app/confirm_order_page.dart';
// import 'package:broadway/food_app/restaurant_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../providerss/app_provider.dart';
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
//     final provider = context.watch<MainProvider>();
//
//     final name = popularItem?.name ?? item?.name ?? '';
//     final description = popularItem?.category ?? item?.description ?? '';
//     final imageUrl = popularItem?.imageUrl ?? item?.imageUrl ?? '';
//     final itemId = popularItem?.id ?? item?.id ?? 0;
//     final price = popularItem?.price ??
//         (item?.prices['default'] is num ? item!.prices['default'].toDouble() : 0.0);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             provider.resetQuantity();
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
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
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     description,
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       imageUrl,
//                       width: double.infinity,
//                       height: 200,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           width: double.infinity,
//                           height: 200,
//                           color: Colors.grey[300],
//                           child: const Icon(Icons.error),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildQuantityButton(Icons.remove, () {
//                         provider.updateQuantity(-1);
//                       }),
//                       const SizedBox(width: 24),
//                       Text(
//                         '${provider.quantity}',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(width: 24),
//                       _buildQuantityButton(Icons.add, () {
//                         provider.updateQuantity(1);
//                       }),
//                     ],
//                   ),
//                   const SizedBox(height: 32),
//                   if (provider.error.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 16),
//                       child: Text(
//                         provider.error,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           spreadRadius: 1,
//                           blurRadius: 10,
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Total Price',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(
//                               '\$${(price * provider.quantity).toStringAsFixed(2)}',
//                               style: const TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Spacer(),
//                         ElevatedButton(
//                           onPressed: provider.isLoading
//                               ? null
//                               : () async {
//                             final success = await provider.addToCart(itemId);
//                             if (success && context.mounted) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Added to cart successfully'),
//                                   backgroundColor: Colors.green,
//                                 ),
//                               );
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xff004CFF),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 32,
//                               vertical: 16,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: provider.isLoading
//                               ? const SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.white,
//                               ),
//                             ),
//                           )
//                               : const Text(
//                             'Add to Cart',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
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
//   Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: const Color(0xffC7D6FB),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         child: Icon(icon, color: const Color(0xff004CFF)),
//       ),
//     );
//   }
// }