import 'package:equatable/equatable.dart';
import 'food_entity.dart';

class RestaurantDetailsEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final String distance;
  final String priceRange;
  final List<String> categories;
  final List<FoodEntity> foods;
  final bool isFavorite;

  const RestaurantDetailsEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.distance,
    required this.priceRange,
    required this.categories,
    required this.foods,
    this.isFavorite = false,
  });

  RestaurantDetailsEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? rating,
    String? deliveryTime,
    String? distance,
    String? priceRange,
    List<String>? categories,
    List<FoodEntity>? foods,
    bool? isFavorite,
  }) {
    return RestaurantDetailsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      distance: distance ?? this.distance,
      priceRange: priceRange ?? this.priceRange,
      categories: categories ?? this.categories,
      foods: foods ?? this.foods,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        rating,
        deliveryTime,
        distance,
        priceRange,
        categories,
        foods,
        isFavorite,
      ];
}



