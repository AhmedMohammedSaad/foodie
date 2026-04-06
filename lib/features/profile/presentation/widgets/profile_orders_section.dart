import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';
import '../../../orders/presentation/cubit/orders_cubit.dart';
import '../../../orders/presentation/cubit/orders_state.dart';
import '../../../orders/presentation/widgets/order_card_widget.dart';
import '../../../orders/presentation/widgets/order_card_shimmer.dart';

class ProfileOrdersSection extends StatelessWidget {
  const ProfileOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 24.h),
              itemCount: 3,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) => const OrderCardShimmer(),
            );
          } else if (state is OrdersSuccess) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 24.h),
              itemCount: state.orders.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return OrderCardWidget(
                  order: order,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.trackOrder,
                      arguments: order.id,
                    );
                  },
                );
              },
            );
          } else if (state is OrdersEmpty) {
            return const _OrdersEmptySection();
          } else if (state is OrdersFailure) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
    );
  }
}

class _OrdersEmptySection extends StatelessWidget {
  const _OrdersEmptySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64.r,
            color: AppColors.textSecondary.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          Text('No orders yet', style: AppTextStyle.font18SemiBold),
          SizedBox(height: 8.h),
          Text(
            'Go explore some delicious food!',
            textAlign: TextAlign.center,
            style: AppTextStyle.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
