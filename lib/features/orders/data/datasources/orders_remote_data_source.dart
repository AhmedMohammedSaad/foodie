import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_model.dart';

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  
  @override
  String toString() => message;
}

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final SupabaseClient supabase;

  OrdersRemoteDataSourceImpl(this.supabase);

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw ServerException('User not authenticated');
      }

      final response = await supabase
          .from('orders')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return (response as List).map((json) => OrderModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
