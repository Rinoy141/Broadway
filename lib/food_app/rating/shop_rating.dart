import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../food_provider.dart';

class ShopRatingPage extends StatelessWidget {
  const ShopRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Shop')),
      body: Consumer<RatingProvider>(
        builder: (context, ratingProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('Assets/image 5.png'), // Replace with actual shop image
                ),
                const SizedBox(height: 16),
                const Text('Shop Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < ratingProvider.shopRating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 30,
                      ),
                      onPressed: () => ratingProvider.setShopRating(index + 1),
                    );
                  }),
                ),
                const Text('Excellent', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: ['Clean', 'Good package', 'Fair price', 'Good food']
                      .map((String tag) {
                    return FilterChip(side: BorderSide.none,showCheckmark: false,
                      selectedColor: const Color(0xff85A8FB),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      label: Text(tag, style: TextStyle(
                        color: ratingProvider.selectedShopTags.contains(tag)
                            ? Colors.white  // Change text color when selected
                            : Colors.black,  // Default text color when not selected
                      ),),
                      selected: ratingProvider.selectedShopTags.contains(tag),
                      onSelected: (_) => ratingProvider.toggleShopTag(tag),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration( fillColor: Colors.grey[100],
                      filled: true,
                      hintText: 'Do you have something to share? Leave a review now!',
                      border:  OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))
                    ),
                    maxLines: 3,
                    onChanged: ratingProvider.setShopComment,
                  ),
                ),
                const SizedBox(height: 16),
                MaterialButton( minWidth: MediaQuery.of(context).size.width * 0.5,
                  color: const Color(0xff004CFF),
                  shape: OutlineInputBorder(borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text('Submit',style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    ratingProvider.submitRatings();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Feedback Submitted'),
                          content: const Text('Thanks for your feedback on our service.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();

                                Navigator.of(context).popUntil((route) => route.isFirst);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}