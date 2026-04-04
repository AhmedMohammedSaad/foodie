import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/restaurant_details_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<RestaurantDetailsModel> getRestaurantDetails(String restaurantId);
  Future<bool> toggleFavorite(String restaurantId);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final SupabaseClient supabase;

  RestaurantRemoteDataSourceImpl(this.supabase);

  @override
  Future<RestaurantDetailsModel> getRestaurantDetails(String restaurantId) async {
    final response = await supabase
        .from('restaurants')
        .select('''
          *,
          foods: menu_items(*),
          restaurant_categories(
            categories(name)
          )
        ''')
        .eq('id', restaurantId)
        .single();
    
    final Map<String, dynamic> data = Map<String, dynamic>.from(response);
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      final fav = await supabase
          .from('favorites')
          .select()
          .eq('user_id', userId)
          .eq('restaurant_id', restaurantId)
          .maybeSingle();
      data['is_favorite'] = fav != null;
    }
    
    return RestaurantDetailsModel.fromJson(data);
  }

  @override
  Future<bool> toggleFavorite(String restaurantId) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return false;

    final favoriteResponse = await supabase
        .from('favorites')
        .select()
        .eq('user_id', userId)
        .eq('restaurant_id', restaurantId)
        .maybeSingle();

    if (favoriteResponse == null) {
      // Add to favorites
      await supabase.from('favorites').insert({
        'user_id': userId,
        'restaurant_id': restaurantId,
      });
      return true;
    } else {
      // Remove from favorites
      await supabase
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('restaurant_id', restaurantId);
      return false;
    }
  }
}
