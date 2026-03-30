import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class TrackOrderView extends StatelessWidget {
  final String orderId;

  const TrackOrderView({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Track Order',
          style: AppTextStyle.font24SemiBold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OrderTrackingHeader(orderId: orderId),
              SizedBox(height: 32.h),
              _TrackingTimelineSection(),
              SizedBox(height: 32.h),
              _CourierInfoSection(),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderTrackingHeader extends StatelessWidget {
  final String orderId;

  const _OrderTrackingHeader({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.access_time_filled,
            color: AppColors.primary,
            size: 40.r,
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estimated Delivery',
                style: AppTextStyle.font14Regular.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                '25 - 30 Minutes',
                style: AppTextStyle.font20Bold,
              ),
              Text(
                'Order #$orderId',
                style: AppTextStyle.font12Medium.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrackingTimelineSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TimelineItem(
          title: 'Order Placed',
          time: '04:30 PM',
          isCompleted: true,
          isCurrent: false,
        ),
        _TimelineLine(isCompleted: true),
        _TimelineItem(
          title: 'Order Confirmed',
          time: '04:35 PM',
          isCompleted: true,
          isCurrent: false,
        ),
        _TimelineLine(isCompleted: true),
        _TimelineItem(
          title: 'Preparing your food',
          time: '04:40 PM',
          isCompleted: true,
          isCurrent: false,
        ),
        _TimelineLine(isCompleted: true),
        _TimelineItem(
          title: 'Order is on the way',
          time: '04:55 PM',
          isCompleted: true,
          isCurrent: true,
        ),
        _TimelineLine(isCompleted: false),
        _TimelineItem(
          title: 'Delivered',
          time: '',
          isLast: true,
          isCompleted: false,
          isCurrent: false,
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String time;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;

  const _TimelineItem({
    required this.title,
    required this.time,
    this.isCompleted = false,
    this.isCurrent = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24.r,
          height: 24.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? AppColors.primary : Colors.grey[200],
            border: isCurrent 
              ? Border.all(color: AppColors.primary, width: 4.r)
              : null,
          ),
          child: isCompleted && !isCurrent 
            ? Icon(Icons.check, size: 14.r, color: Colors.white)
            : null,
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: isCompleted 
                  ? AppTextStyle.font16SemiBold 
                  : AppTextStyle.font16SemiBold.copyWith(color: AppColors.textSecondary),
              ),
              if (time.isNotEmpty)
                Text(
                  time,
                  style: AppTextStyle.font12Medium.copyWith(color: AppColors.textSecondary),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineLine extends StatelessWidget {
  final bool isCompleted;

  const _TimelineLine({this.isCompleted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 11.w),
      width: 2.w,
      height: 48.h,
      color: isCompleted ? AppColors.primary : Colors.grey[200],
    );
  }
}

class _CourierInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
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
          CircleAvatar(
            radius: 30.r,
            backgroundImage: const AssetImage('assets/images/restaurant1.png'), // Mock up courier image
            backgroundColor: AppColors.offWhite,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Mohamed',
                  style: AppTextStyle.font18SemiBold,
                ),
                Text(
                  'Your Courier',
                  style: AppTextStyle.font14Regular.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.call, color: AppColors.primary, size: 24.r),
          ),
        ],
      ),
    );
  }
}
