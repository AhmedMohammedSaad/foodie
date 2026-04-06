import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/di/injection.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import '../widgets/order_card_widget.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrdersCubit>()..loadOrders(),
      child: const OrdersViewBody(),
    );
  }
}

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Orders',
          style: AppTextStyle.font24SemiBold,
        ),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is OrdersSuccess) {
            return _OrdersListSection(orders: state.orders);
          } else if (state is OrdersEmpty) {
            return const _OrdersEmptySection();
          } else if (state is OrdersFailure) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _OrdersListSection extends StatelessWidget {
  final List orders;

  const _OrdersListSection({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(24.r),
      itemCount: orders.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final order = orders[index];
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
  }
}

class _OrdersEmptySection extends StatelessWidget {
  const _OrdersEmptySection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80.r,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            'No orders yet',
            style: AppTextStyle.font18SemiBold,
          ),
          SizedBox(height: 8.h),
          Text(
            'Go explore some delicious food!',
            style: AppTextStyle.font14Regular.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
