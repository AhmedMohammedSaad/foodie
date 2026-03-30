import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/menu_item_entity.dart';

class ProductDetailsView extends StatefulWidget {
  final MenuItemEntity item;
  const ProductDetailsView({super.key, required this.item});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Stack(
              children: [
                Container(
                  height: 400.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50.h,
                  left: 20.w,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Icon(Icons.close, color: AppColors.textPrimary, size: 20.sp),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: AppTextStyle.font32Bold,
                        ),
                      ),
                      Text(
                        '\$${widget.item.price.toStringAsFixed(2)}',
                        style: AppTextStyle.font24SemiBold.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    widget.item.description,
                    style: AppTextStyle.font14Regular.copyWith(height: 1.6),
                  ),
                  SizedBox(height: 32.h),
                  Text('Quantity', style: AppTextStyle.font18SemiBold),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      _quantityButton(Icons.remove, () {
                        if (quantity > 1) setState(() => quantity--);
                      }),
                      SizedBox(width: 24.w),
                      Text(quantity.toString(), style: AppTextStyle.font24SemiBold),
                      SizedBox(width: 24.w),
                      _quantityButton(Icons.add, () => setState(() => quantity++)),
                    ],
                  ),
                  SizedBox(height: 120.h), // Spacing for bottom button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 60.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            ),
            child: Text(
              'Add to Cart - \$${(widget.item.price * quantity).toStringAsFixed(2)}',
              style: AppTextStyle.font16SemiBold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.textSecondary.withOpacity(0.2)),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 20.sp),
      ),
    );
  }
}
