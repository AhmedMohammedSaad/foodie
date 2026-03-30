import 'package:app_food/features/home/presentation/widgets/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_empty_state_widget.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileFavoritesSection extends StatelessWidget {
  const ProfileFavoritesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileSuccess) {
          if (state.favorites.isEmpty) {
            return const AppEmptyStateWidget(
              title: 'No Favorites Yet',
              subtitle: 'Your favorite restaurants will appear here',
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.favorites.length,
            separatorBuilder: (context, index) => 32.verticalSpace,
            itemBuilder: (context, index) {
              final restaurant = state.favorites[index];
              return RestaurantCard(
                restaurant: restaurant,
                isFavorite: true,
                onFavoriteToggle: () {
                  context.read<ProfileCubit>().toggleFavorite(restaurant.id);
                },
              );
            },
          );
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
