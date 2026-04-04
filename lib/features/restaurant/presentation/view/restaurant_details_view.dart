import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/cubit/cart_state.dart';
import '../cubit/restaurant_cubit.dart';
import '../cubit/restaurant_state.dart';
import '../widgets/restaurant_header_section.dart';
import '../widgets/restaurant_info_overlay.dart';
import '../widgets/menu_section.dart';
import '../widgets/restaurant_details_loading_section.dart';

class RestaurantDetailsView extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailsView({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RestaurantCubit>()..getRestaurantDetails(restaurantId),
      child: const RestaurantDetailsViewBody(),
    );
  }
}

class RestaurantDetailsViewBody extends StatelessWidget {
  const RestaurantDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoading) {
            return const RestaurantDetailsLoadingSection();
          } else if (state is RestaurantSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      RestaurantHeaderSection(image: state.restaurant.imageUrl),
                      Positioned(
                        top: 250.h,
                        left: 0,
                        right: 0,
                        child: RestaurantInfoOverlay(restaurant: state.restaurant),
                      ),
                    ],
                  ),
                  SizedBox(height: 160.h), // Spacing for the overlay card
                  MenuSection(
                    restaurant: state.restaurant,
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: (cat) => context.read<RestaurantCubit>().selectCategory(cat),
                  ),
                  SizedBox(height: 100.h), // Bottom padding
                ],
              ),
            );
          } else if (state is RestaurantError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: const RestaurantCartFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class RestaurantCartFloatingActionButton extends StatelessWidget {
  const RestaurantCartFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.items.isNotEmpty) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            height: 60.h,
            width: double.infinity,
            child: FloatingActionButton.extended(
              onPressed: () {
                // Navigate to Cart View later
              },
              backgroundColor: AppColors.primary,
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
              label: SizedBox(
                width: 300.w, // Ensure enough width for the content
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                          child: Text(
                            state.totalItems.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'View Cart',
                          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      '\$${state.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

