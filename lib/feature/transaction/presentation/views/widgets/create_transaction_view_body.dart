import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/widgets/custom_dropdown_field.dart';
import 'package:banking_app/core/widgets/custom_elevated_button.dart';
import 'package:banking_app/core/widgets/custom_text_form_field.dart';
import 'package:banking_app/enums/transaction_type.dart';
import 'package:banking_app/feature/transaction/presentation/cubits/transaction_cubit/transaction_cubit.dart';
import 'package:banking_app/feature/users/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTransactionViewBody extends StatefulWidget {
  const CreateTransactionViewBody({super.key});

  @override
  State<CreateTransactionViewBody> createState() =>
      _CreateTransactionViewBodyState();
}

class _CreateTransactionViewBodyState extends State<CreateTransactionViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _toAccountIdController = TextEditingController();
  final _accountIdController = TextEditingController();

  TransactionType? _selectedType;
  User? _selectedUser; // المستخدم المختار
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    context.read<FetchUsersCubit>().fetchUsers(); // جلب اليوزرز عند init
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _toAccountIdController.dispose();
    _accountIdController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedType == null || _selectedUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('اختر نوع العملية والمستخدم أولاً'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = _selectedUser!.id;
    final amount = int.parse(_amountController.text);
    final description = _descriptionController.text;
    final accountId = int.parse(
      _accountIdController.text,
    ); // string يحتوي على أرقام وحروف
    final toAccountId = _selectedType == TransactionType.transfer
        ? int.parse(_toAccountIdController.text)
        : null;

    context.read<TransactionsCubit>().createTransaction(
      type: _selectedType!,
      userId: userId,
      accountId: accountId, // أو رقم الحساب إذا مختلف
      toAccountId: toAccountId,
      amount: amount,
      description: description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dropdown نوع العملية
              CustomDropdownField(
                label: 'نوع العملية',
                hint: 'اختر نوع العملية',
                value: _selectedType?.label,
                items: TransactionType.values.map((e) => e.label).toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedType = TransactionType.values.firstWhere(
                      (e) => e.label == value,
                      orElse: () => TransactionType.deposit,
                    );
                  });
                },
                validator: (v) => v == null ? 'اختر نوع العملية' : null,
              ),
              SizedBox(height: 20.h),

              // Dropdown المستخدم
              BlocConsumer<FetchUsersCubit, FetchUsersState>(
                listener: (_, state) {
                  if (state is FetchUsersSuccess) {
                    setState(() {
                      _users = state.users;
                    });
                  }
                },
                builder: (_, state) {
                  if (state is FetchUsersLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomDropdownField(
                    label: 'المستخدم',
                    hint: 'اختر المستخدم',
                    value: _selectedUser?.name,
                    items: _users.map((u) => u.name).toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedUser = _users.firstWhere(
                          (u) => u.name == value,
                        );
                      });
                    },
                    validator: (v) => v == null ? 'اختر المستخدم' : null,
                  );
                },
              ),
              SizedBox(height: 20.h),
              // TextField لرقم الحساب
              CustomTextFormField(
                controller: _accountIdController,
                label: 'رقم الحساب',
                hint: "0101010101",
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? 'رقم الحساب مطلوب' : null,
              ),
              SizedBox(height: 20.h),

              // TextField للمبلغ
              CustomTextFormField(
                controller: _amountController,
                label: 'المبلغ',
                hint: "1000",
                keyboardType: TextInputType.number,
                validator: (v) => v == null || int.tryParse(v) == null
                    ? 'مبلغ غير صحيح'
                    : null,
              ),
              SizedBox(height: 20.h),

              // TextField للحساب الوجهة عند التحويل
              if (_selectedType == TransactionType.transfer) ...[
                CustomTextFormField(
                  controller: _toAccountIdController,
                  label: 'رقم الحساب الوجهة',
                  hint: "0101010101",
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || int.tryParse(v) == null
                      ? 'رقم غير صحيح'
                      : null,
                ),
                SizedBox(height: 20.h),
              ],

              // TextField للوصف
              CustomTextFormField(
                controller: _descriptionController,
                label: 'الوصف',
                hint: "معلومات اضافية",
                validator: (v) => v == null || v.isEmpty ? 'الوصف مطلوب' : null,
              ),
              SizedBox(height: 32.h),

              // زر التأكيد + BlocConsumer للـ state
              BlocConsumer<TransactionsCubit, TransactionState>(
                listener: (context, state) {
                  if (state is TransactionSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تمت العملية بنجاح: ${state.type.label}'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    _amountController.clear();
                    _descriptionController.clear();
                    _toAccountIdController.clear();
                  }
                  if (state is TransactionFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('فشل العملية: ${state.errMessage}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is TransactionLoading;
                  return CustomElevatedButton(
                    title: isLoading ? 'جارٍ التنفيذ...' : 'تأكيد العملية',
                    onPressed: isLoading ? () {} : _submit,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
