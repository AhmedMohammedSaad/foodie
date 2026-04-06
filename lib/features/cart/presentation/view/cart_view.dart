import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../sections/cart_items_list_section.dart';
import '../sections/cart_summary_section.dart';
import '../../../../core/presentation/view/widgets/app_empty_state_widget.dart';

import '../widgets/cart_item_shimmer.dart';

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
          Widget content;
          if (state.status == CartStatus.loading && state.items.isEmpty) {
            content = ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(20.r),
              itemCount: 3,
              separatorBuilder: (context, index) => 16.verticalSpace,
              itemBuilder: (context, index) => const CartItemShimmer(),
            );
          } else if (state.status == CartStatus.success || state.status == CartStatus.initial || state.status == CartStatus.loading) {
            if (state.items.isEmpty) {
              content = ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  const _CartEmptySection(),
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () async {
                        await context.read<CartCubit>().loadCart();
                      },
                      child: CartItemsListSection(items: state.items),
                    ),
                  ),
                  CartSummarySection(
                    totalPrice: state.totalPrice,
                    totalItems: state.totalItems,
                  ),
                ],
              );
            }
          } else if (state.status == CartStatus.error) {
            content = ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                Center(child: Text(state.errorMessage ?? 'An error occurred')),
              ],
            );
          } else {
            content = const SizedBox.shrink();
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              await context.read<CartCubit>().loadCart();
            },
            child: content,
          );
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
