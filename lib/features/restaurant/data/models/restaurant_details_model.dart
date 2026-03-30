import '../../domain/entities/restaurant_details_entity.dart';
import 'menu_item_model.dart';

class RestaurantDetailsModel extends RestaurantDetailsEntity {
  const RestaurantDetailsModel({
    required super.id,
    required super.name,
    required super.description,
    required super.coverImage,
    required super.rating,
    required super.deliveryTime,
    required super.distance,
    required super.priceRange,
    required super.categories,
    required super.menuItems,
  });

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverImage: json['coverImage'],
      rating: (json['rating'] as num).toDouble(),
      deliveryTime: json['deliveryTime'],
      distance: json['distance'],
      priceRange: json['priceRange'],
      categories: List<String>.from(json['categories']),
      menuItems: (json['menuItems'] as List)
          .map((item) => MenuItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coverImage': coverImage,
      'rating': rating,
      'deliveryTime': deliveryTime,
      'distance': distance,
      'priceRange': priceRange,
      'categories': categories,
      'menuItems': menuItems.map((item) => (item as MenuItemModel).toJson()).toList(),
    };
  }
}
