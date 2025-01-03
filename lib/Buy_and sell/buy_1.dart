//
// import 'package:flutter/material.dart';
// import '../common/colors.dart';
// import '../common/images.dart';
// import '../main.dart';
//
// class Buy extends StatefulWidget {
//   const Buy({super.key});
//
//   @override
//   State<Buy> createState() => _BuyState();
// }
// List cakes=[
//   {
//     "image":theImages.blackforest,
//     "name":"Chocolate Icing",
//     "product":"Cake",
//     "price":"699 Rs",
//   },
//   {
//     "image":theImages.chocolate,
//     "name":"Black Forest  ",
//     "product":"Cake",
//     "price":"799 Rs",
//   },
//   {
//     "image":theImages.blackforest,
//     "name":"Chocolate Icing",
//     "product":"Cake",
//     "price":"699 Rs",
//   },
// ];
// List mango=[
//   {
//     "image":theImages.saltedmango,
//     "Name":"saltedmango",
//     "products":"mango",
//     "RS":"100 Rs",
//   },
//   {
//     "image":theImages.saltedmango,
//     "Name":"saltedmango",
//     "products":"mango",
//     "RS":"150 Rs",
//   },
//   {
//     "image":theImages.saltedmango,
//     "Name":"saltedmango",
//     "products":"mango",
//     "RS":"200 Rs",
//   },
// ];
// class _BuyState extends State<Buy> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.arrow_back),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.45,
//             child: Stack(
//               children: [
//                 Positioned(
//                   right: MediaQuery.of(context).size.width * 0.40,
//                   child: Image.asset(
//                     theImages.sideview,
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     width: MediaQuery.of(context).size.width * 0.6,
//                   ),
//                 ),
//                 Positioned(
//                   left: MediaQuery.of(context).size.width * 0.69,
//                   bottom: MediaQuery.of(context).size.height * 0.13,
//                   child: Image.asset(
//                     theImages.sideview2,
//                     height: MediaQuery.of(context).size.height * 0.36,
//                     width: MediaQuery.of(context).size.width * 0.36,
//                   ),
//                 ),
//                 Positioned(
//                   top: w*0.1,
//                   left: MediaQuery.of(context).size.width * 0.15,
//                   child: Center(
//                     child: Container(
//                       child:Column(
//                         children: [
//                           Row(
//                             children: [
//                               Image.asset(theImages.uidesigner),
//                               SizedBox(width: w*0.03,),
//                               Text('Vishnu V N')
//                             ],
//                           ),
//                         ],
//                       )
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: h*0.2,
//             child: Expanded(
//               child: Container(
//                 height: h*0.9,
//                 decoration: BoxDecoration(
//                   color: thecolors.primaryColor,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(h * 0.1),
//                     topRight: Radius.circular(h * 0.1),
//                   ),
//                 ),
//                 // Add extra height by reducing padding/margin above or increasing proportions.
//                 padding: EdgeInsets.only(top: h * 0.05), // Add some top padding to extend visually
//                 // child: GridView.builder(
//                 //   padding: EdgeInsets.all(16.0),
//                 //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 //     crossAxisCount: 2,
//                 //     crossAxisSpacing: 12.0,
//                 //     mainAxisSpacing: 12.0,
//                 //     childAspectRatio: 0.8,
//                 //   ),
//                 //   itemCount: cakes.length,
//                 //   itemBuilder: (context, index) {
//                 //     final item = cakes[index];
//                 //     return Container(
//                 //       decoration: BoxDecoration(
//                 //         borderRadius: BorderRadius.circular(w * 0.03),
//                 //         color: thecolors.grey4,
//                 //       ),
//                 //       padding: EdgeInsets.all(8.0),
//                 //       child: Column(
//                 //         crossAxisAlignment: CrossAxisAlignment.start,
//                 //         children: [
//                 //           Expanded(
//                 //             child: Image.asset(
//                 //               item["image"],
//                 //               fit: BoxFit.cover,
//                 //             ),
//                 //           ),
//                 //           SizedBox(height: 8.0),
//                 //           Text(
//                 //             item['name'],
//                 //             style: TextStyle(fontWeight: FontWeight.w700),
//                 //           ),
//                 //           Text(
//                 //             item["product"],
//                 //             style: TextStyle(fontWeight: FontWeight.w700),
//                 //           ),
//                 //           SizedBox(height: 8.0),
//                 //           Row(
//                 //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //             children: [
//                 //               Text(
//                 //                 item["price"],
//                 //                 style: TextStyle(
//                 //                   fontWeight: FontWeight.w900,
//                 //                   color: Colors.blue,
//                 //                 ),
//                 //               ),
//                 //               Icon(Icons.shopping_cart_outlined, color: Colors.blue),
//                 //             ],
//                 //           ),
//                 //         ],
//                 //       ),
//                 //     );
//                 //   },
//                 // ),
//               ),
//             ),
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }
import 'package:broadway/common/colors.dart';

import 'dart:ui';
import 'package:broadway/common/images.dart';
import 'package:flutter/material.dart';

import '../food_app/confirm_order_page.dart';
 // import '../../../broadway/lib/common/colors.dart';
// import '../../../broadway/lib/common/images.dart';
//  import '../../../broadway/lib/Buy and_sell/buy_1 cart.da
import 'dart:ui';

class Buy extends StatefulWidget {
  const Buy({super.key});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  final List<Map<String, dynamic>> cakes = [
    {
      "image": theImages.blackforest,
      "name": "Chocolate Icing",
      "product": "Cake",
      "price": "699 Rs",
    },
    {
      "image": theImages.chocolate,
      "name": "Black Forest",
      "product": "Cake",
      "price": "799 Rs",
    },
    {
      "image": theImages.blackforest,
      "name": "Chocolate Icing",
      "product": "Cake",
      "price": "699 Rs",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Buy Items'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              // Top Section
              Container(
                height: h * 0.7,
                child: Stack(
                  children: [
                    Positioned(
                      right: w * 0.40,
                      child: Image.asset(
                        theImages.sideview,
                        height: h * 0.4,
                        width: w * 0.6,
                      ),
                    ),
                    Positioned(
                      left: w * 0.69,
                      bottom: h * 0.40,
                      child: Image.asset(
                        theImages.sideview2,
                        height: h * 0.36,
                        width: w * 0.36,
                      ),
                    ),
                    Positioned(
                      top: h * 0.1,
                      left: w * 0.15,
                      child: Row(
                        children: [
                          Image.asset(
                            theImages.uidesigner,
                            height: h * 0.05,
                            width: h * 0.05,
                          ),
                          SizedBox(width: w * 0.03),
                          Text(
                            'Vishnu V N',
                            style: TextStyle(fontSize: h * 0.025),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom Section
              Positioned(
                 top: h * 0.18, // Adjusted to start slightly lower
                left: 0,
                right: 0,

                child: Container(
                  height: h * 0.9,
                  decoration: BoxDecoration(
                    color: thecolors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(h * 0.1),
                      topRight: Radius.circular(h * 0.1),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: h * 0.05),
                    child: GridView.builder(
                      padding: EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: cakes.length,
                      itemBuilder: (context, index) {
                        final item = cakes[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(
                              image: item['image'],
                              name: item['name'],
                              product: item['product'],
                              price: item['price'].toString(),),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w * 0.03),
                              color: thecolors.gray4,
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    item["image"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  item['name'],
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  item["product"],
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item["price"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Icon(Icons.shopping_cart_outlined, color: Colors.blue),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: h*0.01),
          Container(
            height: h*0.16,
            width: w*0.9,
            decoration:  BoxDecoration(
              color: thecolors.blow2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(h * 0.1),
                topRight: Radius.circular(h * 0.1),
              ),
            ),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(w*0.08),
                child: SingleChildScrollView(
                  child: Container(
                    child: TextFormField(
                         decoration: InputDecoration(
                           hintText: 'Place Order here',
                          suffixIcon: Icon(Icons.send),
                          border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(w * 0.03),
                         ),
                           fillColor: Colors.white,
                           filled: true
                    ),
                              ),
                  ),
                ),
              ),
            ],
          )
          )],
      ),

    );
  }
}
