import 'package:banking_app/core/utils/app_colors.dart';
import 'package:banking_app/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardHeader extends StatelessWidget {
  final String title;

  const DashboardHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.w600_24.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, size: 24.sp),
                onPressed: () {},
              ),
              SizedBox(width: 16.w),
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.person, color: Colors.white, size: 20.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
