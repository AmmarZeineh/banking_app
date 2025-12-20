import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/helper_functions/snack_bars.dart';
import 'package:banking_app/core/utils/app_colors.dart';
import 'package:banking_app/core/utils/app_font_styles.dart';
import 'package:banking_app/core/widgets/custom_dropdown_field.dart';
import 'package:banking_app/core/widgets/custom_elevated_button.dart';
import 'package:banking_app/core/widgets/custom_text_form_field.dart';
import 'package:banking_app/enums/account_type_enum.dart';
import 'package:banking_app/feature/account/domain/entities/create_account_params.dart';
import 'package:banking_app/feature/account/presentation/cubits/create_account_cubit/create_account_cubit.dart';
import 'package:banking_app/feature/account/presentation/cubits/fetch_users_for_create_account_cubit/fetch_users_for_create_account_cubit.dart';
import 'package:banking_app/feature/account/presentation/views/widgets/create_account_header.dart';
import 'package:banking_app/feature/account/presentation/views/widgets/user_dropdown.dart';
import 'package:banking_app/feature/account/presentation/views/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountViewBody extends StatefulWidget {
  const CreateAccountViewBody({super.key});

  @override
  State<CreateAccountViewBody> createState() => _CreateAccountViewBodyState();
}

class _CreateAccountViewBodyState extends State<CreateAccountViewBody> {
  final _formKey = GlobalKey<FormState>();

  final _currencyController = TextEditingController();
  final _overdraftLimitController = TextEditingController();
  final _parentAccountIdController = TextEditingController();
  final _accountLabelController = TextEditingController();
  final _interestRateController = TextEditingController();

  String _selectedAccountType = AccountType.savings.name.toUpperCase();
  User? _selectedUser;

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'SAR', 'AED'];

  @override
  void dispose() {
    _currencyController.dispose();
    _overdraftLimitController.dispose();
    _parentAccountIdController.dispose();
    _accountLabelController.dispose();
    _interestRateController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _selectedUser = null;
      _selectedAccountType = 'SAVINGS';
    });
    _currencyController.clear();
    _overdraftLimitController.clear();
    _parentAccountIdController.clear();
    _accountLabelController.clear();
    _interestRateController.clear();
  }

  @override
  void initState() {
    context.read<FetchUsersForCreateAccountCubit>().fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // Header
          DashboardHeader(title: 'إنشاء حساب بنكي جديد'),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(32.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Section
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(32.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'معلومات الحساب',
                              style: AppTextStyles.w700_18.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(height: 24.h),

                            // User Dropdown
                            BlocBuilder<
                              FetchUsersForCreateAccountCubit,
                              FetchUsersForCreateAccountState
                            >(
                              builder: (context, state) {
                                if (state
                                    is FetchUsersForCreateAccountLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is FetchUsersForCreateAccountSuccess) {
                                  return UserDropdownField(
                                    selectedUser: _selectedUser,
                                    users: state.usersList,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedUser = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'هذا الحقل مطلوب';
                                      }
                                      return null;
                                    },
                                  );
                                }
                                return Center(
                                  child: CustomElevatedButton(
                                    title: 'اعد المحاولة',
                                    onPressed: () async {
                                      await context
                                          .read<
                                            FetchUsersForCreateAccountCubit
                                          >()
                                          .fetchUsers();
                                    },
                                  ),
                                );
                              },
                            ),

                            // User Info Card
                            if (_selectedUser != null) ...[
                              SizedBox(height: 12.h),
                              UserInfoCard(user: _selectedUser!),
                            ],
                            SizedBox(height: 20.h),

                            // Account Type and Currency
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdownField(
                                    label: 'نوع الحساب *',
                                    hint: 'اختر نوع الحساب',
                                    value: _selectedAccountType,
                                    items: AccountType.values
                                        .map((type) => type.name.toUpperCase())
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedAccountType = value!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: CustomDropdownField(
                                    label: 'العملة *',
                                    hint: 'اختر العملة',
                                    value: null,
                                    items: _currencies,
                                    onChanged: (value) {
                                      _currencyController.text = value!;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'هذا الحقل مطلوب';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),

                            // Account Label
                            CustomTextFormField(
                              controller: _accountLabelController,
                              label: 'تسمية الحساب *',
                              hint: 'أدخل اسم الحساب',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'هذا الحقل مطلوب';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),

                            // Overdraft Limit and Interest Rate
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: _overdraftLimitController,
                                    label: 'حد السحب على المكشوف *',
                                    hint: 'أدخل الحد الأقصى',
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'هذا الحقل مطلوب';
                                      }
                                      if (double.tryParse(value) == null) {
                                        return 'يجب إدخال رقم صحيح';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: _interestRateController,
                                    label: 'معدل الفائدة (%) *',
                                    hint: 'أدخل معدل الفائدة',
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'هذا الحقل مطلوب';
                                      }
                                      if (double.tryParse(value) == null) {
                                        return 'يجب إدخال رقم صحيح';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 32.h),

                            // Buttons
                            BlocConsumer<
                              CreateAccountCubit,
                              CreateAccountState
                            >(
                              listener: (context, state) {
                                if (state is CreateAccountSuccess) {
                                  showSuccessMessage(
                                    'تم انشاء الحساب بنجاح',
                                    context,
                                  );
                                  _resetForm();
                                } else if (state is CreateAccountFailure) {
                                  showErrorMessage(
                                    'فشل انشاء الحساب بسبب ${state.message}',
                                    context,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: CustomElevatedButton(
                                        title: 'انشاء حساب',
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (_selectedUser == null) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'الرجاء اختيار المستخدم',
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            } else {
                                              CreateAccountParams
                                              createAccountParams =
                                                  CreateAccountParams(
                                                    userId: _selectedUser!.id,
                                                    accountType:
                                                        _selectedAccountType,
                                                    currency:
                                                        _currencyController
                                                            .text,
                                                    overdraftLimit: int.parse(
                                                      _overdraftLimitController
                                                          .text,
                                                    ),
                                                    interestRate: int.parse(
                                                      _interestRateController
                                                          .text,
                                                    ),
                                                    accountLabel:
                                                        _accountLabelController
                                                            .text,
                                                    parentAccountId: int.tryParse(
                                                      _parentAccountIdController
                                                          .text,
                                                    ),
                                                  );
                                              await context
                                                  .read<CreateAccountCubit>()
                                                  .createAccount(
                                                    createAccountParams:
                                                        createAccountParams,
                                                  );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        title: 'اعادة تعيين',
                                        onPressed: () {
                                          _resetForm();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
