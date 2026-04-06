import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/search_item_entity.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchItemEntity>> search(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final SupabaseClient supabase;

  SearchRemoteDataSourceImpl(this.supabase);

  @override
  Future<List<SearchItemEntity>> search(String query) async {
    if (query.isEmpty) return [];

    final restaurantFuture = supabase
        .from('restaurants')
        .select('id, name, cuisine, image_url')
        .ilike('name', '%$query%');

    final foodFuture = supabase
        .from('menu_items')
        .select('id, name, image_url, restaurant_id, restaurants(name)')
        .ilike('name', '%$query%');

    final results = await Future.wait([restaurantFuture, foodFuture]);

    final List<SearchItemEntity> searchItems = [];

    // Process Restaurants
    final List<dynamic> restaurants = results[0] as List<dynamic>;
    for (var res in restaurants) {
      searchItems.add(SearchItemEntity(
        id: res['id'].toString(),
        title: res['name'] ?? '',
        subtitle: res['cuisine'] ?? '',
        image: res['image_url'] ?? '',
        type: SearchItemType.restaurant,
      ));
    }

    // Process Foods (Menu Items)
    final List<dynamic> foods = results[1] as List<dynamic>;
    for (var food in foods) {
      final restaurantData = food['restaurants'] as Map<String, dynamic>?;
      searchItems.add(SearchItemEntity(
        id: food['id'].toString(),
        title: food['name'] ?? '',
        subtitle: restaurantData?['name'] ?? '',
        image: food['image_url'] ?? '',
        type: SearchItemType.food,
        restaurantId: food['restaurant_id']?.toString(),
      ));
    }

    return searchItems;
  }
}
