import '../../domain/entities/search_item_entity.dart';

class SearchLocalDataSource {
  final List<SearchItemEntity> _mockData = [
    // Restaurants
    const SearchItemEntity(
      id: '1',
      title: 'Healthy Bites',
      subtitle: 'Salads • Healthy',
      image: 'assets/images/restaurant1.png',
      type: SearchItemType.restaurant,
    ),
    const SearchItemEntity(
      id: '2',
      title: 'Pizza Hub',
      subtitle: 'Pizza • Italian',
      image: 'assets/images/restaurant2.png',
      type: SearchItemType.restaurant,
    ),
    const SearchItemEntity(
      id: '3',
      title: 'Burger Palace',
      subtitle: 'Burgers • American',
      image: 'assets/images/restaurant1.png',
      type: SearchItemType.restaurant,
    ),
    // Foods / Meals
    const SearchItemEntity(
      id: '101',
      title: 'Classic Margherita',
      subtitle: 'Pizza Hub',
      image: 'assets/images/pizza.png',
      type: SearchItemType.food,
      restaurantId: '2',
    ),
    const SearchItemEntity(
      id: '102',
      title: 'Double Cheeseburger',
      subtitle: 'Burger Palace',
      image: 'assets/images/burger.png',
      type: SearchItemType.food,
      restaurantId: '3',
    ),
    const SearchItemEntity(
      id: '103',
      title: 'Quinoa Salad',
      subtitle: 'Healthy Bites',
      image: 'assets/images/salad.png',
      type: SearchItemType.food,
      restaurantId: '1',
    ),
    const SearchItemEntity(
      id: '104',
      title: 'Spicy Pepperoni',
      subtitle: 'Pizza Hub',
      image: 'assets/images/pizza.png',
      type: SearchItemType.food,
      restaurantId: '2',
    ),
  ];

  Future<List<SearchItemEntity>> search(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (query.isEmpty) return [];
    
    return _mockData.where((item) {
      final titleMatch = item.title.toLowerCase().contains(query.toLowerCase());
      final subtitleMatch = item.subtitle.toLowerCase().contains(query.toLowerCase());
      return titleMatch || subtitleMatch;
    }).toList();
  }
}
