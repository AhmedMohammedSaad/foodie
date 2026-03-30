import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';
import '../models/restaurant_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<RestaurantModel>> getPopularRestaurants();
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
}
