import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providerss/app_provider.dart';

class ShopRatingPage extends StatefulWidget {
  final int restaurantId;

  const ShopRatingPage({super.key, required this.restaurantId});

  @override
  _ShopRatingPageState createState() => _ShopRatingPageState();
}

class _ShopRatingPageState extends State<ShopRatingPage> {
  @override
  void initState() {
    super.initState();

    // Use post-frame callback to fetch details after the first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      mainProvider.fetchRestaurantDetails(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Restaurant')),
      body: Consumer<MainProvider>(
        builder: (context, mainProvider, child) {
          // Remove the fetchRestaurantDetails call from here

          // Loading state
          if (mainProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final restaurant = mainProvider.restaurantDetails;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: restaurant?.imageUrl != null
                      ? NetworkImage(restaurant!.imageUrl!)
                      : const AssetImage('Assets/image 5.png') as ImageProvider,
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 16),
                Text(
                  restaurant?.restaurantName ?? 'Restaurant Name',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                RatingSection(restaurantId: widget.restaurantId),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RatingSection extends StatefulWidget {
  final int restaurantId;

  const RatingSection({super.key, required this.restaurantId});

  @override
  _RatingSectionState createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  int _rating = 0;
  Set<String> _selectedTags = {};
  String _reviewComment = '';
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Star Rating
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1;
                });
              },
            );
          }),
        ),

        // Tag Chips (existing code)
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: ['Clean', 'Good package', 'Fair price', 'Good food']
              .map((String tag) {
            return FilterChip(
              side: BorderSide.none,
              showCheckmark: false,
              selectedColor: const Color(0xff85A8FB),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              label: Text(
                tag,
                style: TextStyle(
                  color: _selectedTags.contains(tag)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              selected: _selectedTags.contains(tag),
              onSelected: (_) {
                setState(() {
                  if (_selectedTags.contains(tag)) {
                    _selectedTags.remove(tag);
                  } else {
                    _selectedTags.add(tag);
                  }
                });
              },
            );
          }).toList(),
        ),

        // Review TextField
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              filled: true,
              hintText: 'Do you have something to share? Leave a review now!',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            maxLines: 3,
            onChanged: (value) {
              setState(() {
                _reviewComment = value;
              });
            },
          ),
        ),

        // Submit Button
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width * 0.5,
          color: const Color(0xff004CFF),
          shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: _isSubmitting || _rating == 0
              ? null
              : () async {
            setState(() {
              _isSubmitting = true;
            });

            final mainProvider = Provider.of<MainProvider>(context, listen: false);
            final success = await mainProvider.addRestaurantReview(
                context: context,
                restaurantId: widget.restaurantId,
                rating: _rating.toInt(),
                review: _reviewComment.isNotEmpty
                    ? _reviewComment
                    : _selectedTags.join(', ')
            );

            setState(() {
              _isSubmitting = false;
            });

            if (success) {

              await showDialog(
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
            }
          },
          child: _isSubmitting
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}