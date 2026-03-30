import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/search_item_entity.dart';
import '../cubit/search_cubit.dart';

class SearchResultsSection extends StatelessWidget {
  const SearchResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: const CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        } else if (state is SearchEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off_outlined,
                    size: 64.r,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No results found',
                    style: AppTextStyle.font16Medium,
                  ),
                ],
              ),
            ),
          );
        } else if (state is SearchLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 24.h),
            itemCount: state.mockResults.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return _SearchItemWidget(item: state.mockResults[index]);
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
                child: Center(
                  child: Icon(
                    item.type == SearchItemType.restaurant ? Icons.storefront : Icons.fastfood_outlined,
                    color: AppColors.primary,
                    size: 32.r,
                  ),
                ),
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
}
