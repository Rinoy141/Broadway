class Restaurant {
  final String name;
  final String location;
  final String image;
  final bool isOpen;
  final double rating;
  final String distance;
  final String deliveryTime;
  final List<PopularItem>? popularItems;
  final List<ItemCategory> foodCategories;

  Restaurant({
    required this.name,
    required this.location,
    required this.image,
    required this.isOpen,
    required this.rating,
    required this.distance,
    required this.deliveryTime,
    this.popularItems,
    required this.foodCategories,
  });
}

class PopularItem {
  final String name;
  final double price;
  final String category;
  final String imageUrl;

  PopularItem({
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
  });
}

class ItemCategory {
  final String name;
  final List<Item> items;

  ItemCategory({
    required this.name,
    required this.items,
  });
}

class Item {
  final String name;
  final Map<String, double> prices; // Changed to map for different sizes
  final String imageUrl;
  final String description;
  final String category;

  Item({
    required this.name,
    required this.prices,
    required this.imageUrl,
    required this.description,
    required this.category,
  });
}


