import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../../providerss/app_provider.dart';

class RatingProvider extends ChangeNotifier {
  // Rating state
  int _rating = 0;
  int get rating => _rating;

  // Selected tags state
  Set<String> _selectedTags = {};
  Set<String> get selectedTags => _selectedTags;

  // Review comment state
  String _reviewComment = '';
  String get reviewComment => _reviewComment;

  // Submission state
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  // Available tags
  final List<String> availableTags = ['Clean', 'Good package', 'Fair price', 'Good food'];

  // to set rating
  void setRating(int rating) {
    _rating = rating;
    notifyListeners();
  }

  //to toggle tag selection
  void toggleTag(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    notifyListeners();
  }

  // to update review comment
  void updateReviewComment(String comment) {
    _reviewComment = comment;
    notifyListeners();
  }

  //  to submit review
  Future<bool> submitReview({
    required BuildContext context,
    required int restaurantId,
    required MainProvider mainProvider
  }) async {
    if (_rating == 0) return false;

    _isSubmitting = true;
    notifyListeners();

    final success = await mainProvider.addRestaurantReview(
        context: context,
        restaurantId: restaurantId,
        rating: _rating,
        review: _reviewComment.isNotEmpty
            ? _reviewComment
            : _selectedTags.join(', ')
    );

    _isSubmitting = false;
    notifyListeners();

    return success;
  }

  //  to reset the form
  void resetForm() {
    _rating = 0;
    _selectedTags.clear();
    _reviewComment = '';
    _isSubmitting = false;
    notifyListeners();
  }
}