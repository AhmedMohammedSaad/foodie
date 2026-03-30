import 'package:equatable/equatable.dart';

class MenuItemEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String? category;
  final bool isBestSeller;
  final bool isVegetarian;

  const MenuItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.category,
    this.isBestSeller = false,
    this.isVegetarian = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        image,
        category,
        isBestSeller,
        isVegetarian,
      ];
}
