import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../../../../core/presentation/view/widgets/app_empty_state_widget.dart';
import 'restaurant_card.dart';

class HomePopularSection extends StatelessWidget {
  const HomePopularSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Near You',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF482603),
                      ),
                    ),
                    Row(
                      children: [
                        _ArrowButton(icon: Icons.chevron_left),
                        8.horizontalSpace,
                        _ArrowButton(icon: Icons.chevron_right),
                      ],
                    ),
                  ],
                ),
              ),
              if (state.filteredRestaurants.isEmpty)
                const AppEmptyStateWidget(
                  title: 'No restaurants found',
                  subtitle: 'Try adjusting your filters or search keywords',
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  itemCount: state.filteredRestaurants.length,
                  separatorBuilder: (context, index) => 32.verticalSpace,
                  itemBuilder: (context, index) {
                    final restaurant = state.filteredRestaurants[index];
                    return RestaurantCard(
                      restaurant: restaurant,
                      isFavorite: state.favoriteIds.contains(restaurant.id),
                      onFavoriteToggle: () {
                        context.read<HomeCubit>().toggleFavorite(restaurant.id);
                      },
                    );
                  },

                ),
              120.verticalSpace, // Space for bottom nav
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  const _ArrowButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFD9A274).withOpacity(0.3)),
      ),
      child: Icon(icon, color: const Color(0xFF482603), size: 20.sp),
    );
  }
}
