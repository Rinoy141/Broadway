import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providerss/app_provider.dart';
import '../state providers/rating_provider.dart';


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

class RatingSection extends StatelessWidget {
  final int restaurantId;

  const RatingSection({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RatingProvider(),
      child: Builder(
        builder: (context) {
          final ratingProvider = Provider.of<RatingProvider>(context);
          final mainProvider = Provider.of<MainProvider>(context, listen: false);

          return Column(
            children: [
              // Star Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < ratingProvider.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 30,
                    ),
                    onPressed: () {
                      ratingProvider.setRating(index + 1);
                    },
                  );
                }),
              ),

              // Tag Chips
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: ratingProvider.availableTags.map((String tag) {
                  return FilterChip(
                    side: BorderSide.none,
                    showCheckmark: false,
                    selectedColor: const Color(0xff85A8FB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    label: Text(
                      tag,
                      style: TextStyle(
                        color: ratingProvider.selectedTags.contains(tag)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    selected: ratingProvider.selectedTags.contains(tag),
                    onSelected: (_) {
                      ratingProvider.toggleTag(tag);
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
                    ratingProvider.updateReviewComment(value);
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
                onPressed: ratingProvider.rating == 0 || ratingProvider.isSubmitting
                    ? null
                    : () async {
                  final success = await ratingProvider.submitReview(
                    context: context,
                    restaurantId: restaurantId,
                    mainProvider: mainProvider,
                  );

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
                                ratingProvider.resetForm();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: ratingProvider.isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}