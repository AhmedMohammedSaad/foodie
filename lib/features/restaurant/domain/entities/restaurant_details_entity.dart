import 'package:equatable/equatable.dart';
import 'menu_item_entity.dart';

class RestaurantDetailsEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String coverImage;
  final double rating;
  final String deliveryTime;
  final String distance;
  final String priceRange;
  final List<String> categories;
  final List<MenuItemEntity> menuItems;
  final bool isFavorite;

  const RestaurantDetailsEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.rating,
    required this.deliveryTime,
    required this.distance,
    required this.priceRange,
    required this.categories,
    required this.menuItems,
    this.isFavorite = false,
  });

  RestaurantDetailsEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? coverImage,
    double? rating,
    String? deliveryTime,
    String? distance,
    String? priceRange,
    List<String>? categories,
    List<MenuItemEntity>? menuItems,
    bool? isFavorite,
  }) {
    return RestaurantDetailsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      rating: rating ?? this.rating,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      distance: distance ?? this.distance,
      priceRange: priceRange ?? this.priceRange,
      categories: categories ?? this.categories,
      menuItems: menuItems ?? this.menuItems,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        coverImage,
        rating,
        deliveryTime,
        distance,
        priceRange,
        categories,
        menuItems,
        isFavorite,
      ];
}
