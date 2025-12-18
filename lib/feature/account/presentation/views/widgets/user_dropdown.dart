import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/utils/app_colors.dart';
import 'package:banking_app/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDropdownField extends StatelessWidget {
  final User? selectedUser;
  final List<User> users;
  final ValueChanged<User?> onChanged;
  final String? Function(User?)? validator;

  const UserDropdownField({
    super.key,
    required this.selectedUser,
    required this.users,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المستخدم *', style: AppTextStyles.w600_14),
        SizedBox(height: 8.h),
        DropdownButtonFormField<User>(
          initialValue: selectedUser,
          decoration: _inputDecoration('اختر المستخدم'),
          isExpanded: true,
          items: users.map((user) {
            return DropdownMenuItem<User>(
              value: user,
              child: Text(
                '${user.name} - ID: ${user.nationalId}',
                style: AppTextStyles.w400_14,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.w400_14.copyWith(color: Colors.grey[400]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      filled: true,
      fillColor: Colors.grey[50],
    );
  }
}
