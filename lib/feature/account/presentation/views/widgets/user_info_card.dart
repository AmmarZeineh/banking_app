import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoCard extends StatelessWidget {
  final User user;

  const UserInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.blue[700], size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'معلومات المستخدم',
                style: AppTextStyles.w600_14.copyWith(color: Colors.blue[900]),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildDetailRow('الاسم', user.name),
          _buildDetailRow('المعرف', user.id.toString()),
          _buildDetailRow('الرقم الوطني', user.nationalId),
          _buildDetailRow('البريد الإلكتروني', user.email),
          Row(
            children: [
              Text(
                'حالة البريد: ',
                style: AppTextStyles.w500_12.copyWith(color: Colors.grey[700]),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: user.isEmailVerified
                      ? Colors.green[100]
                      : Colors.orange[100],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  user.isEmailVerified ? 'موثق' : 'غير موثق',
                  style: AppTextStyles.w600_12.copyWith(
                    color: user.isEmailVerified
                        ? Colors.green[900]
                        : Colors.orange[900],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: AppTextStyles.w500_12.copyWith(color: Colors.grey[700]),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.w600_12.copyWith(color: Colors.grey[900]),
            ),
          ),
        ],
      ),
    );
  }
}
