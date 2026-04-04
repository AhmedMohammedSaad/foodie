import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../sections/cart_items_list_section.dart';
import '../sections/cart_summary_section.dart';
import '../../../../core/presentation/view/widgets/app_empty_state_widget.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: AppTextStyle.font24SemiBold,
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.status == CartStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state.status == CartStatus.success || state.status == CartStatus.initial) {
            if (state.items.isEmpty) {
              return const _CartEmptySection();
            }
            return Column(
              children: [
                Expanded(
                  child: CartItemsListSection(items: state.items),
                ),
                CartSummarySection(
                  totalPrice: state.totalPrice,
                  totalItems: state.totalItems,
                ),
              ],
            );
          } else if (state.status == CartStatus.error) {
            return Center(child: Text(state.errorMessage ?? 'An error occurred'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _CartEmptySection extends StatelessWidget {
  const _CartEmptySection();

  @override
  Widget build(BuildContext context) {
    return const AppEmptyStateWidget(
      title: 'Your cart is empty',
      subtitle: 'Add some delicious food to your cart and it will show up here!',
      icon: Icons.shopping_cart_outlined,
    );
  }
}
