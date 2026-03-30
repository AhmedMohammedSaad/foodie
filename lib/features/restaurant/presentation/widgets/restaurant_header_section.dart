import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/restaurant_cubit.dart';
import '../cubit/restaurant_state.dart';
import 'restaurant_header_button.dart';
import '../../../../core/theme/app_colors.dart';

class RestaurantHeaderSection extends StatelessWidget {
  final String image;
  const RestaurantHeaderSection({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantCubit>();
    
    return Stack(
      children: [
        // Background Image
        Container(
          height: 300.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Overlay Gradient for readability
        Container(
          height: 300.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Header Buttons
        Positioned(
          top: 50.h,
          left: 20.w,
          right: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RestaurantHeaderButton(
                icon: Icons.arrow_back_ios_new,
                onTap: () => Navigator.pop(context),
              ),
              BlocBuilder<RestaurantCubit, RestaurantState>(
                builder: (context, state) {
                  bool isFavorite = false;
                  if (state is RestaurantSuccess) {
                    isFavorite = state.restaurant.isFavorite;
                  }
                  return RestaurantHeaderButton(
                    icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                    iconColor: isFavorite ? Colors.red : AppColors.textPrimary,
                    onTap: () => cubit.toggleFavorite(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
