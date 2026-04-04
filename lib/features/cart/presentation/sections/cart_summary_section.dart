import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/presentation/view/widgets/app_default_button.dart';

class CartSummarySection extends StatelessWidget {
  final double totalPrice;
  final int totalItems;

  const CartSummarySection({
    super.key,
    required this.totalPrice,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    const deliveryFee = 5.0; // Mock delivery fee
    final finalTotal = totalPrice + deliveryFee;

    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryRow(
              label: 'Subtotal ($totalItems items)',
              value: '\$${totalPrice.toStringAsFixed(2)}',
            ),
            SizedBox(height: 12.h),
            _SummaryRow(
              label: 'Delivery Fee',
              value: '\$${deliveryFee.toStringAsFixed(2)}',
            ),
            SizedBox(height: 16.h),
            const Divider(),
            SizedBox(height: 16.h),
            _SummaryRow(
              label: 'Total',
              value: '\$${finalTotal.toStringAsFixed(2)}',
              isTotal: true,
            ),
            SizedBox(height: 24.h),
            AppDefaultButton(
              text: 'Proceed to Checkout',
              onPressed: () {
                // Handle checkout logic later
              },
            ),
            SizedBox(height: 48.h), // Extra space for bottom nav overlap safety
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyle.font18SemiBold
              : AppTextStyle.font14MediumProfile.copyWith(color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyle.font20BoldAccount.copyWith(color: AppColors.primary)
              : AppTextStyle.font16SemiBold,
        ),
      ],
    );
  }
}
