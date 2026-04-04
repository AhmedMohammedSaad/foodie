import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';
import '../models/restaurant_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<RestaurantModel>> getPopularRestaurants();
  Future<List<String>> getFavoriteIds();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient supabase;

  HomeRemoteDataSourceImpl(this.supabase);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await supabase
        .from('categories')
        .select()
        .order('name', ascending: true);
    
    return (response as List)
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }

  @override
  Future<List<RestaurantModel>> getPopularRestaurants() async {
    final response = await supabase
        .from('restaurants')
        .select('*, restaurant_categories(category_id)')
        .order('rating', ascending: false);
    
    return (response as List)
        .map((restaurant) => RestaurantModel.fromJson(restaurant))
        .toList();
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await supabase
        .from('favorites')
        .select('restaurant_id, food_id')
        .eq('user_id', userId);
    
    final List<String> favoriteIds = [];
    for (var fav in (response as List)) {
      if (fav['restaurant_id'] != null) {
        favoriteIds.add(fav['restaurant_id'] as String);
      }
      if (fav['food_id'] != null) {
        favoriteIds.add(fav['food_id'] as String);
      }
    }
    return favoriteIds;
  }
}
