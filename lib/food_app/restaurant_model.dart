import 'package:flutter/material.dart';

class Restaurant {
  final int id;
  final String restaurantName;
  final String district;
  final String place;
  final double? averageRating;
  final String openingTime;
  final String closingTime;
  final int distance;
  final dynamic deliveryFee;
  final List<dynamic> promoCode;
  final String? imageUrl;

  Restaurant({
    required this.id,
    required this.restaurantName,
    required this.district,
    required this.place,
    this.averageRating,
    required this.openingTime,
    required this.closingTime,
    required this.distance,
    required this.deliveryFee,
    required this.promoCode,
    this.imageUrl,
  });

  bool get isOpen {
    try {
      final now = DateTime.now();
      final openTime = _parseTimeString(openingTime);
      final closeTime = _parseTimeString(closingTime);

      final todayOpenTime = DateTime(
        now.year, now.month, now.day,
        openTime.hour, openTime.minute,
      );

      final todayCloseTime = DateTime(
        now.year, now.month, now.day,
        closeTime.hour, closeTime.minute,
      );

      if (todayCloseTime.isBefore(todayOpenTime)) {
        if (now.isBefore(todayCloseTime)) return true;
        if (now.isAfter(todayOpenTime)) return true;
        return false;
      }

      return now.isAfter(todayOpenTime) && now.isBefore(todayCloseTime);
    } catch (e) {
      print('Error calculating restaurant open status: $e');
      return false;
    }
  }

  TimeOfDay _parseTimeString(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      restaurantName: json['Restaurant_Name'],
      district: json['District'],
      place: json['Place'],
      averageRating: json['average_rating'],
      openingTime: json['Opening_time'],
      closingTime: json['Closing_time'],
      distance: json['distance'],
      deliveryFee: json['deliveryfee'],
      promoCode: json['promocode'],
      imageUrl: json['image_url'],
    );
  }
}

class PopularItem {
  final int id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;

  PopularItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  factory PopularItem.fromJson(Map<String, dynamic> json) {
    return PopularItem(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      category: json['category'],
      imageUrl: json['imageUrl'],
    );
  }
}

class FoodCategory {
  final String name;
  final List<Item> items;

  FoodCategory({
    required this.name,
    required this.items,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      name: json['name'],
      items: (json['items'] as List)
          .map((itemJson) => Item.fromJson(itemJson))
          .toList(),
    );
  }
}

class Item {
  final int id;
  final String name;
  final Map<String, dynamic> prices;
  final String imageUrl;
  final String description;

  Item({
    required this.id,
    required this.name,
    required this.prices,
    required this.imageUrl,
    required this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      prices: json['prices'],
      imageUrl: json['imageUrl'],
      description: json['description'],
    );
  }
}

class NearbyRestaurant {
  final String image;
  final String name;
  final String location;
  final double distance;
  final String rating;
  final String status;
  final int deliveryFee;

  NearbyRestaurant({
    required this.image,
    required this.name,
    required this.location,
    required this.distance,
    required this.rating,
    required this.status,
    required this.deliveryFee,
  });

  factory NearbyRestaurant.fromJson(Map<String, dynamic> json) {
    return NearbyRestaurant(
      image: json['image'] ?? '',
      name: json['restaurant'] ?? '',
      location: json['address'] ?? '',
      distance: (json['distance_km'] is num)
          ? (json['distance_km'] as num).toDouble()
          : 0.0,
      rating: json['rating'] ?? 'No ratings yet',
      status: json['status'] ?? 'Unknown',
      deliveryFee: json['delivery_fee'] is num
          ? (json['delivery_fee'] as num).toInt()
          : 0,
    );
  }
}

