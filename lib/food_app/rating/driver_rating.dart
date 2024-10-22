import 'package:broadway/food_app/rating/shop_rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../food_provider.dart';

class DriverRatingPage extends StatelessWidget {
  const DriverRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Driver')),
      body: Consumer<RatingProvider>(
        builder: (context, ratingProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'Assets/image 6.png'), // Replace with actual driver image
                ),
                const SizedBox(height: 16),
                const Text('Driver Name',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < ratingProvider.driverRating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 40,
                      ),
                      onPressed: () =>
                          ratingProvider.setDriverRating(index + 1),
                    );
                  }),
                ),
                const Text('Excellent', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    'Good Service',
                    'On Time',
                    'Clean',
                    'Careful',
                    'Work Hard',
                    'Polite'
                  ].map((String tag) {
                    return FilterChip(side: BorderSide.none,showCheckmark: false,
                      selectedColor: const Color(0xff85A8FB),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      label: Text(tag, style: TextStyle(
                      color: ratingProvider.selectedDriverTags.contains(tag)
                          ? Colors.white  // Change text color when selected
                          : Colors.black,  // Default text color when not selected
                    ),),
                      selected: ratingProvider.selectedDriverTags.contains(tag),
                      onSelected: (_) => ratingProvider.toggleDriverTag(tag),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    style: TextStyle(color: Colors.grey[600]),
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText:
                          'Do you have something to share? Leave a review now!',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    maxLines: 3,
                    onChanged: ratingProvider.setDriverComment,
                  ),
                ),
                const SizedBox(height: 16),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  color: const Color(0xff004CFF),
                  shape: OutlineInputBorder(borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),

                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShopRatingPage()),
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
