import '../../domain/entities/menu_item_entity.dart';

class MenuItemModel extends MenuItemEntity {
  const MenuItemModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.image,
    super.category,
    super.isBestSeller,
    super.isVegetarian,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      category: json['category'],
      isBestSeller: json['isBestSeller'] ?? false,
      isVegetarian: json['isVegetarian'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'isBestSeller': isBestSeller,
      'isVegetarian': isVegetarian,
    };
  }
}
