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
      image: 'https://broadway.icgedu.com${json['image']}',
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
      image: 'https://broadway.icgedu.com${json['image']}',
      name: json['restaurant'] ?? '',
      location: json['address'] ?? '',
      distance: (json['distance_km'] is num)
          ? (json['distance_km'] as num).toDouble()
          : 0.0,
      rating: json['rating'] != null ? json['rating'].toString() : 'No ratings yet',
      status: json['status'] ?? 'Unknown',
      deliveryFee: json['delivery_fee'] is num
          ? (json['delivery_fee'] as num).toInt()
          : 0,
    );
  }
}

class Category {
  final int id;
  final String categoryName;
  final String imageUrl;

  Category({
    required this.id,
    required this.categoryName,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    print('Parsing category from JSON: $json'); // Debug print
    const baseUrl = 'https://broadway.icgedu.com';
    String imageUrl = json['Image'] ?? '';
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      imageUrl = '$baseUrl$imageUrl';
    }

    return Category(
      id: json['id'],
      categoryName: json['Categorie_name'],
      imageUrl: imageUrl,
    );
  }
}

class MenuItem {
  final int id;
  final int restaurantId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.restaurantId,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      restaurantId: json['Restaurant'],
      name: json['Item'],
      description: json['Description'],
      price: json['Price'],
      imageUrl: json['Image'],
    );
  }
}

class CartItem {
  final int id;
  final MenuItems menuItems;
  final String itemName;
   int quantity;
  final double price;
  final double totalPrice;
  final double deliveryCharge;
  final double offerPrice;
  final int restaurantId;
  final int customerId;
  final int menuItemId;

  CartItem({
    required this.id,
    required this.menuItems,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.deliveryCharge,
    required this.offerPrice,
    required this.restaurantId,
    required this.customerId,
    required this.menuItemId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      menuItems: MenuItems.fromJson(json['Menuitem']),
      itemName: json['Item_name'],
      quantity: json['Quantity'],
      price: (json['Price'] as num).toDouble(),
      totalPrice: (json['TotalPrice'] as num).toDouble(),
      deliveryCharge: (json['DeliveryCharge'] as num).toDouble(),
      offerPrice: (json['Offer_Price'] as num).toDouble(),
      restaurantId: json['Restaurant_id'],
      customerId: json['Customer_id'],
      menuItemId: json['Menuitem_id'],
    );
  }
}

class MenuItems {
  final String image;

  MenuItems({required this.image});

  factory MenuItems.fromJson(Map<String, dynamic> json) {
    return MenuItems(
      image: json['Image'],
    );
  }
}

class ProfileModel {
  final String username;
  final String email;
  final String phoneNumber;
  final String address;
  final String country;
  final String district;
  final String place;
  final String? idImage;
  final String gender;
  final String? profilePic;

  ProfileModel({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.country,
    required this.district,
    required this.place,
    this.idImage,
    required this.gender,
    this.profilePic,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['Username'] ?? '',
      email: json['Email'] ?? '',
      phoneNumber: json['Phonenumber'] ?? '',
      address: json['Address'] ?? '',
      country: json['Country'] ?? '',
      district: json['District'] ?? '',
      place: json['Place'] ?? '',
      idImage: json['Id_Image'],
      gender: json['Gender'] ?? '',
      profilePic: json['Profile_pic'],
    );
  }
}

class OrderHistoryItem {
  final int id;
  final int restaurantId;
  final String customerName;
  final String customerLocation;
  final String customerPhoneNumber;
  final String itemName;
  final int quantity;
  final double price;
  final String status;
  final DateTime dateTime;
  final double deliveryCharge;
  final double totalPrice;
  final double offerPrice;
  final String paymentMethod;
  final String promoCode;
  final bool promoUsed;
  final OrderRestaurantDetails restaurantDetails;

  OrderHistoryItem({
    required this.id,
    required this.restaurantId,
    required this.customerName,
    required this.customerLocation,
    required this.customerPhoneNumber,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.status,
    required this.dateTime,
    required this.deliveryCharge,
    required this.totalPrice,
    required this.offerPrice,
    required this.paymentMethod,
    required this.promoCode,
    required this.promoUsed,
    required this.restaurantDetails,
  });

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) {
    return OrderHistoryItem(
      id: json['id'] ?? 0,
      restaurantId: json['Restaurant_id'] ?? 0,
      customerName: json['Customer_Name'] ?? '',
      customerLocation: json['Customer_Location'] ?? '',
      customerPhoneNumber: json['Customer_Phonenumber'] ?? '',
      itemName: json['Item_name'] ?? '',
      quantity: json['Quantity'] ?? 0,
      price: (json['Price'] ?? 0.0).toDouble(),
      status: json['status'] ?? '',
      dateTime: DateTime.parse(json['DateTime'] ?? DateTime.now().toIso8601String()),
      deliveryCharge: (json['Deliverycharge'] ?? 0.0).toDouble(),
      totalPrice: (json['TotalPrice'] ?? 0.0).toDouble(),
      offerPrice: (json['Offer_price'] ?? 0.0).toDouble(),
      paymentMethod: json['Payment_method'] ?? '',
      promoCode: json['PromoCode'] ?? '0',
      promoUsed: json['PromoUsed'] ?? false,
      restaurantDetails: OrderRestaurantDetails.fromJson(json['Restaurant_details'] ?? {}),
    );
  }
}

class OrderRestaurantDetails {
  final String restaurantName;
  final String image;
  final String place;
  final int id;

  OrderRestaurantDetails({
    required this.restaurantName,
    required this.image,
    required this.place,
    required this.id,
  });

  factory OrderRestaurantDetails.fromJson(Map<String, dynamic> json) {
    return OrderRestaurantDetails(
      restaurantName: json['Restaurant_Name'] ?? '',
      image: json['Image'] ?? '',
      place: json['Place'] ?? '',
      id: json['id'] ?? 0,
    );
  }
}

///for popular section and recommended section
class RestaurantModel {
  final int id;
  final String name;
  final String image;
  final double rating;
  final int distance;
  final int deliveryFee;
  final String location;
  final String status;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.distance,
    required this.deliveryFee,
    required this.location,
    required this.status,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['restaurant_name'],
      image: json['image'],
      rating: json['rating'].toDouble(),
      distance: json['distance'],
      deliveryFee: json['delivery_fee'],
      location: json['location'],
      status: json['status'],
    );
  }
}

class Review {
  final int id;
  final String customerName;
  final String review;
  final int rating;

  Review({
    required this.id,
    required this.customerName,
    required this.review,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      customerName: json['Customer_Name'],
      review: json['Review'],
      rating: json['Rating'],
    );
  }
}