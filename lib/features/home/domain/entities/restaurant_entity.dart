import 'package:equatable/equatable.dart';

class RestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String image;
  final double rating;
  final String deliveryTime;
  final String priceRange; // e.g., "$", "$$"
  final String cuisine;
  final List<String> tags; // e.g., ["FREE DELIVERY", "BEST SELLER", "PROMOTED", "MICHELIN GUIDE"]
  final String categoryId;
  final double distance;
  final double price;
  final bool isFavorite;

  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.deliveryTime,
    required this.priceRange,
    required this.cuisine,
    required this.categoryId,
    required this.distance,
    required this.price,
    this.tags = const [],
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        rating,
        deliveryTime,
        priceRange,
        cuisine,
        categoryId,
        distance,
        price,
        tags,
        isFavorite,
      ];
}
