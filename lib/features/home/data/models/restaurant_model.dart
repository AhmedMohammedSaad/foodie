import '../../domain/entities/restaurant_entity.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.image,
    required super.rating,
    required super.deliveryTime,
    required super.priceRange,
    required super.cuisine,
    required super.categoryId,
    required super.distance,
    required super.price,
    super.tags,
    super.isFavorite,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      image: json['image_url'] ?? json['image'], // Try both for backwards compatibility
      rating: (json['rating'] as num).toDouble(),
      deliveryTime: json['delivery_time'] ?? json['deliveryTime'],
      priceRange: json['price_range'] ?? json['priceRange'],
      cuisine: json['cuisine'],
      categoryId: (json['restaurant_categories'] as List?)?.isNotEmpty == true
          ? (json['restaurant_categories'][0]['category_id'] as String)
          : (json['category_id'] ?? json['categoryId'] ?? ''),
      distance: (json['distance'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      tags: List<String>.from(json['tags'] ?? []),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'deliveryTime': deliveryTime,
      'priceRange': priceRange,
      'cuisine': cuisine,
      'categoryId': categoryId,
      'distance': distance,
      'price': price,
      'tags': tags,
      'isFavorite': isFavorite,
    };
  }
}
