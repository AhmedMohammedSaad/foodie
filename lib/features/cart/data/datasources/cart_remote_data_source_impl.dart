import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cart_remote_data_source.dart';
import '../models/cart_item_model.dart';

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final SupabaseClient supabase;

  CartRemoteDataSourceImpl({required this.supabase});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User is not authenticated');

      final response = await supabase
          .from('cart_items')
          .select('*, menu_items(*)')
          .eq('user_id', userId)
          .order('created_at', ascending: true);

      return (response as List).map((json) => CartItemModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error getting cart items: $e');
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addToCart(String foodId, int quantity) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User is not authenticated');

      // Check if food already in cart
      final existingItem = await supabase
          .from('cart_items')
          .select()
          .eq('user_id', userId)
          .eq('food_id', foodId)
          .maybeSingle();

      if (existingItem != null) {
        // Update quantity
        final newQuantity = existingItem['quantity'] + quantity;
        if (newQuantity <= 0) {
          await supabase.from('cart_items').delete().eq('id', existingItem['id']);
        } else {
          await supabase
              .from('cart_items')
              .update({'quantity': newQuantity})
              .eq('id', existingItem['id']);
        }
      } else {
        if (quantity <= 0) return;
        // Insert new
        await supabase.from('cart_items').insert({
          'user_id': userId,
          'food_id': foodId,
          'quantity': quantity,
        });
      }
    } catch (e) {
      debugPrint('Error adding to cart: $e');
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeFromCart(String cartItemId) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User is not authenticated');

      await supabase
          .from('cart_items')
          .delete()
          .eq('id', cartItemId)
          .eq('user_id', userId);
    } catch (e) {
      debugPrint('Error removing from cart: $e');
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User is not authenticated');

      await supabase
          .from('cart_items')
          .delete()
          .eq('user_id', userId);
    } catch (e) {
      debugPrint('Error clearing cart: $e');
      throw Exception(e.toString());
    }
  }
}
