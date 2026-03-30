import 'package:equatable/equatable.dart';

enum SearchItemType { restaurant, food }

class SearchItemEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle; // Restaurant name for food, or category for restaurant
  final String image;
  final SearchItemType type;
  final String? restaurantId; // Only for food items, to navigate to the correct restaurant details

  const SearchItemEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.type,
    this.restaurantId,
  });

  @override
  List<Object?> get props => [id, title, subtitle, image, type, restaurantId];
}
