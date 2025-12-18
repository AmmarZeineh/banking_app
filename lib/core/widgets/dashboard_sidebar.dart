import 'package:banking_app/core/utils/app_colors.dart';
import 'package:banking_app/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      color: AppColors.primaryColor,
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Text(
              'Bank Dashboard',
              style: AppTextStyles.w700_20.copyWith(color: Colors.white),
            ),
          ),
          Divider(color: Colors.white24),
          _buildSidebarItem(Icons.dashboard, 'Dashboard', true),
          _buildSidebarItem(Icons.account_balance, 'Accounts', false),
          _buildSidebarItem(Icons.people, 'Users', false),
          _buildSidebarItem(Icons.settings, 'Settings', false),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 20.sp),
        title: Text(
          title,
          style: AppTextStyles.w500_14.copyWith(color: Colors.white),
        ),
        dense: true,
      ),
    );
  }
}
