import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_item_widget.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartItemsListSection extends StatelessWidget {
  final List<CartItemEntity> items;

  const CartItemsListSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(24.r),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return CartItemWidget(
          item: item,
          onIncrement: () {
            // addToCart in CartCubit expects String foodId, int quantity
            context.read<CartCubit>().addToCart(item.food.id, 1, existingItem: item);
          },
          onDecrement: () {
            // addToCart in CartCubit expects String foodId, int quantity
            context.read<CartCubit>().addToCart(item.food.id, -1, existingItem: item);
          },
          onRemove: () {
            context.read<CartCubit>().removeFromCart(item.id);
          },
        );
      },
    );
  }
}
