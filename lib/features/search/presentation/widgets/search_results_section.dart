import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_empty_state_widget.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/search_item_entity.dart';
import '../cubit/search_cubit.dart';
import 'search_item_shimmer.dart';

class SearchResultsSection extends StatelessWidget {
  const SearchResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const SearchListShimmer();
        } else if (state is SearchEmpty) {
          return const AppEmptyStateWidget(
            title: 'No results found',
            subtitle: 'Try searching for something else.',
            icon: Icons.search_off_outlined,
          );
        } else if (state is SearchError) {
          return AppEmptyStateWidget(
            title: 'Something went wrong',
            subtitle: state.message,
            icon: Icons.error_outline,
          );
        } else if (state is SearchLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 24.h),
            itemCount: state.results.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return _SearchItemWidget(item: state.results[index]);
            },
          );
        }
        
        // Initial State
        return Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Column(
            children: [
              Icon(
                Icons.search_outlined,
                size: 64.r,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 16.h),
              Text(
                'Type to start searching for\nrestaurants or meals',
                textAlign: TextAlign.center,
                style: AppTextStyle.font14Regular,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchItemWidget extends StatelessWidget {
  final SearchItemEntity item;

  const _SearchItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.type == SearchItemType.restaurant) {
          Navigator.pushNamed(context, Routes.restaurantDetails, arguments: item.id);
        } else {
          if (item.restaurantId != null) {
            Navigator.pushNamed(context, Routes.restaurantDetails, arguments: item.restaurantId);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: item.image.startsWith('http') 
                  ? Image.network(
                      item.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholderIcon(),
                    )
                  : (item.image.isNotEmpty 
                      ? Image.asset(item.image, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _buildPlaceholderIcon())
                      : _buildPlaceholderIcon()),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: AppTextStyle.font16SemiBold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: item.type == SearchItemType.restaurant 
                              ? AppColors.primary.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          item.type == SearchItemType.restaurant ? 'Restaurant' : 'Meal',
                          style: AppTextStyle.font12Medium.copyWith(
                            color: item.type == SearchItemType.restaurant 
                                ? AppColors.primary
                                : Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.subtitle,
                    style: AppTextStyle.font14Regular.copyWith(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.r,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Center(
      child: Icon(
        item.type == SearchItemType.restaurant ? Icons.storefront : Icons.fastfood_outlined,
        color: AppColors.primary,
        size: 32.r,
      ),
    );
  }
}
