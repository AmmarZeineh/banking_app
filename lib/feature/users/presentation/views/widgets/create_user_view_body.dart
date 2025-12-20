import 'package:banking_app/core/helper_functions/snack_bars.dart';
import 'package:banking_app/core/utils/app_colors.dart';
import 'package:banking_app/core/utils/app_font_styles.dart';
import 'package:banking_app/core/widgets/custom_elevated_button.dart';
import 'package:banking_app/core/widgets/custom_text_form_field.dart';
import 'package:banking_app/feature/users/domain/entities/create_user_params.dart';
import 'package:banking_app/feature/users/presentation/cubits/create_user_cubit/create_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateUserViewBody extends StatefulWidget {
  const CreateUserViewBody({super.key});

  @override
  State<CreateUserViewBody> createState() => _CreateUserViewBodyState();
}

class _CreateUserViewBodyState extends State<CreateUserViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int _selectedRoleId = 3;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final List<Map<String, dynamic>> _roles = [
    {'id': 1, 'name': 'مدير', 'icon': Icons.admin_panel_settings},
    {'id': 2, 'name': 'موظف', 'icon': Icons.work},
    {'id': 3, 'name': 'مستخدم', 'icon': Icons.person},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _nameController.clear();
    _emailController.clear();
    _nationalIdController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // أيقونة المستخدم
            Center(
              child: Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_add,
                  size: 50.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 30.h),

            // حقل الاسم
            CustomTextFormField(
              controller: _nameController,
              label: 'الاسم الكامل',
              hint: 'أدخل الاسم الكامل',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال الاسم';
                }
                if (value.length < 3) {
                  return 'الاسم يجب أن يكون 3 أحرف على الأقل';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // حقل البريد الإلكتروني
            CustomTextFormField(
              controller: _emailController,
              label: 'البريد الإلكتروني',
              hint: 'example@email.com',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'يرجى إدخال بريد إلكتروني صحيح';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // حقل الرقم الوطني
            CustomTextFormField(
              controller: _nationalIdController,
              label: 'الرقم الوطني',
              hint: 'أدخل الرقم الوطني (11 رقم)',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال الرقم الوطني';
                }
                if (value.length != 11) {
                  return 'الرقم الوطني يجب أن يكون 11 رقم';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // حقل كلمة المرور
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('كلمة المرور', style: AppTextStyles.w600_14),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: AppTextStyles.w400_14,
                  decoration: InputDecoration(
                    hintText: 'أدخل كلمة المرور',
                    hintStyle: AppTextStyles.w400_14.copyWith(
                      color: Colors.grey[400],
                    ),
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
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال كلمة المرور';
                    }
                    if (value.length < 6) {
                      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                    }
                    return null;
                  },
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // حقل تأكيد كلمة المرور
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تأكيد كلمة المرور', style: AppTextStyles.w600_14),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  style: AppTextStyles.w400_14,
                  decoration: InputDecoration(
                    hintText: 'أعد إدخال كلمة المرور',
                    hintStyle: AppTextStyles.w400_14.copyWith(
                      color: Colors.grey[400],
                    ),
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
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى تأكيد كلمة المرور';
                    }
                    if (value != _passwordController.text) {
                      return 'كلمة المرور غير متطابقة';
                    }
                    return null;
                  },
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // اختيار الدور الوظيفي
            Text('الدور الوظيفي', style: AppTextStyles.w600_16),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: _roles.map((role) {
                final isSelected = _selectedRoleId == role['id'];
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        role['icon'],
                        size: 18.sp,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                      SizedBox(width: 6.w),
                      Text(role['name']),
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedRoleId = role['id'];
                    });
                  },
                  selectedColor: AppColors.primaryColor,
                  backgroundColor: Colors.grey[200],
                  labelStyle: AppTextStyles.w500_16.copyWith(
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24.h),

            // خيار التحقق من البريد
            BlocConsumer<CreateUserCubit, CreateUserState>(
              listener: (context, state) {
                if (state is CreateUserSuccess) {
                  showSuccessMessage('تم انشاء المستخدم بنجاح', context);
                  _resetForm();
                } else if (state is CreateUserFailure) {
                  showErrorMessage(state.message, context);
                }
              },
              builder: (context, state) {
                if (state is CreateUserLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomElevatedButton(
                  title: 'انشاء',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      CreateUserParams createUserParams = CreateUserParams(
                        email: _emailController.text,
                        name: _nameController.text,
                        password: _passwordController.text,
                        roleId: _selectedRoleId,
                        nationalId: _nationalIdController.text,
                      );
                      await context.read<CreateUserCubit>().createUser(
                        createUserParams,
                      );
                    }
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
