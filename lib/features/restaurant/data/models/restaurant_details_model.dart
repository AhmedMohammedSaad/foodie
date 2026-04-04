import '../../domain/entities/restaurant_details_entity.dart';
import 'food_model.dart';

class RestaurantDetailsModel extends RestaurantDetailsEntity {
  const RestaurantDetailsModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.rating,
    required super.deliveryTime,
    required super.distance,
    required super.priceRange,
    required super.categories,
    required super.foods,
    super.isFavorite,
  });

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    // Handling nested categories from Supabase: restaurant_categories(categories(name))
    List<String> parsedCategories = [];
    if (json['restaurant_categories'] != null) {
      parsedCategories = (json['restaurant_categories'] as List)
          .map((item) => item['categories']?['name']?.toString())
          .whereType<String>()
          .toList();
    } else if (json['categories'] != null) {
      parsedCategories = List<String>.from(json['categories']);
    }

    return RestaurantDetailsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      deliveryTime: json['delivery_time']?.toString() ?? '',
      distance: json['distance']?.toString() ?? '',
      priceRange: json['price_range']?.toString() ?? '',
      categories: parsedCategories,
      foods: json['foods'] != null
          ? (json['foods'] as List)
              .map((item) => FoodModel.fromJson(item))
              .toList()
          : [],
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'rating': rating,
      'delivery_time': deliveryTime,
      'distance': distance,
      'price_range': priceRange,
      'categories': categories,
      'is_favorite': isFavorite,
      'foods': foods.map((item) => (item as FoodModel).toJson()).toList(),
    };
  }
}



