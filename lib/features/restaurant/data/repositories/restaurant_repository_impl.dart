import '../../../../core/models/api_result.dart';
import '../../domain/entities/restaurant_details_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../models/restaurant_details_model.dart';
import '../models/menu_item_model.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  @override
  Future<ApiResult<RestaurantDetailsEntity>> getRestaurantDetails(String restaurantId) async {
    // Mocking API call
    await Future.delayed(const Duration(seconds: 1));

    // For demonstration, returning the same high-fidelity mock data for any ID
    final mockDetails = RestaurantDetailsModel(
      id: restaurantId,
      name: "L'Antica Pizzeria",
      description: "Authentic wood-fired Neapolitan pizzas crafted with heirloom tomatoes and hand-pulled mozzarella.",
      coverImage: 'assets/images/artisan_pizza_home.png',
      rating: 4.9,
      deliveryTime: '20 mins',
      distance: '1.2 miles',
      priceRange: r'$$',
      categories: const ['Pizzas', 'Sides', 'Drinks', 'Desserts'],
      menuItems: const [
        MenuItemModel(
          id: 'm1',
          name: 'Truffle Honey Margherita',
          description: 'San Marzano tomatoes, fresh basil, buffalo mozzarella, and truffle honey.',
          price: 18.50,
          image: 'assets/images/artisan_pizza_home.png',
          category: 'Pizzas',
          isBestSeller: true,
        ),
        MenuItemModel(
          id: 'm2',
          name: 'Burrata & Prosciutto',
          description: 'Creamy whole burrata ball, aged prosciutto di parma, wild arugula.',
          price: 22.00,
          image: 'assets/images/artisan_pizza_home.png',
          category: 'Pizzas',
        ),
        MenuItemModel(
          id: 'm3',
          name: 'Wild Mushroom Bianco',
          description: 'Roasted shiitake and oyster mushrooms, garlic cream base.',
          price: 19.50,
          image: 'assets/images/artisan_pizza_home.png',
          category: 'Pizzas',
          isVegetarian: true,
        ),
        MenuItemModel(
          id: 'm4',
          name: 'Calabrese Salami',
          description: 'Spicy Calabrian salami, red onion, black olives, and chili honey.',
          price: 20.00,
          image: 'assets/images/artisan_pizza_home.png',
          category: 'Pizzas',
        ),
      ],
    );

    return ApiResult.success(mockDetails);
  }
}
