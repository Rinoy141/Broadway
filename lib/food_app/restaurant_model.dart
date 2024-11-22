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
  final List<PromoCode> promoCodes;
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
    required this.promoCodes,
    this.imageUrl,
  });

  bool get isOpen {
    try {
      final now = DateTime.now();
      final openTime = parseTimeString(openingTime);
      final closeTime = parseTimeString(closingTime);

      final todayOpenTime = DateTime(
        now.year,
        now.month,
        now.day,
        openTime.hour,
        openTime.minute,
      );

      final todayCloseTime = DateTime(
        now.year,
        now.month,
        now.day,
        closeTime.hour,
        closeTime.minute,
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

  TimeOfDay parseTimeString(String timeStr) {
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
      promoCodes: (json['promocode'] as List)
          .map((promoJson) => PromoCode.fromJson(promoJson))
          .toList(),
      imageUrl: json['image_url'],
    );
  }
}
class PromoCode {
  final String code;
  final double value;

  PromoCode({
    required this.code,
    required this.value,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    return PromoCode(
      code: json['code'],
      value: json['value'],
    );
  }
}
// best_seller_model.dart

class BestSeller {
  final int id;
  final String restaurantName;
  final String image;
  final String district;
  final double rating;
  final int distance;
  final String status;
  final int deliveryFee;
  final List<BestSellerPromo> bestSellers;

  BestSeller({
    required this.id,
    required this.restaurantName,
    required this.image,
    required this.district,
    required this.rating,
    required this.distance,
    required this.status,
    required this.deliveryFee,
    required this.bestSellers,
  });

  factory BestSeller.fromJson(Map<String, dynamic> json) {
    return BestSeller(
      id: json['id'] ?? 0,
      restaurantName: json['restaurant_name'] ?? '',
      image: json['image'] != null
          ? 'http://broadway.extramindtech.com${json['image']}'
          : '',
      district: json['district'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      distance: json['distance'] ?? 0,
      status: json['status'] ?? 'Closed',
      deliveryFee: json['delivery_fee'] ?? 0,
      bestSellers: json['bestsellers'] != null
          ? List<BestSellerPromo>.from(
          json['bestsellers'].map((x) => BestSellerPromo.fromJson(x)))
          : [],
    );
  }
}

class BestSellerPromo {
  final String code;
  final double value;
  final DateTime startDate;
  final DateTime endDate;

  BestSellerPromo({
    required this.code,
    required this.value,
    required this.startDate,
    required this.endDate,
  });

  factory BestSellerPromo.fromJson(Map<String, dynamic> json) {
    return BestSellerPromo(
      code: json['Code'] ?? '',
      value: (json['Value'] ?? 0.0).toDouble(),
      startDate: json['Start_Date'] != null
          ? DateTime.parse(json['Start_Date'])
          : DateTime.now(),
      endDate: json['End_Date'] != null
          ? DateTime.parse(json['End_Date'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Code': code,
      'Value': value,
      'Start_Date': startDate.toIso8601String(),
      'End_Date': endDate.toIso8601String(),
    };
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
  final int id;
  final String image;
  final String name;
  final String location;
  final double distance;
  final String rating;
  final String status;
  final int deliveryFee;

  NearbyRestaurant({
    required this.id,
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
      id: json['id']??'',
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

