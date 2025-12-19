import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/helper_functions/snack_bars.dart';
import 'package:banking_app/core/services/get_it_service.dart';
import 'package:banking_app/feature/users/domain/users_repo.dart';
import 'package:banking_app/feature/users/presentation/cubits/delete_user_cubit/delete_user_cubit.dart';
import 'package:banking_app/feature/users/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsView extends StatelessWidget {
  static const routeName = 'user_details';
  final User user;

  const UserDetailsView({super.key, required this.user});

  String _getRoleName(int roleId) {
    switch (roleId) {
      case 1:
        return 'مدير';
      case 2:
        return 'موظف';
      case 3:
        return 'مستخدم';
      default:
        return 'غير محدد';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المستخدم'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => DeleteUserCubit(getIt.get<UsersRepo>()),
          child: Column(
            children: [
              // صورة المستخدم الكبيرة
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // معلومات المستخدم
              _buildInfoCard([
                _InfoItem(
                  icon: Icons.person,
                  label: 'الاسم',
                  value: user.name,
                  trailing: BlocConsumer<DeleteUserCubit, DeleteUserState>(
                    listener: (context, state) async {
                      if (state is DeleteUserSuccess) {
                        showSuccessMessage('تم حذف المستخدم بنجاح', context);
                        await context.read<FetchUsersCubit>().fetchUsers();
                        Navigator.pop(context);
                      } else if (state is DeleteUserFailure) {
                        showErrorMessage(state.message, context);
                      }
                    },
                    builder: (context, state) {
                      if (state is DeleteUserLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await context.read<DeleteUserCubit>().deleteUser(
                            user.id.toString(),
                          );
                        },
                      );
                    },
                  ),
                ),
                _InfoItem(
                  icon: Icons.email,
                  label: 'البريد الإلكتروني',
                  value: user.email,
                  trailing: user.isEmailVerified
                      ? const Icon(Icons.verified, color: Colors.blue, size: 20)
                      : const Icon(Icons.cancel, color: Colors.red, size: 20),
                ),
                _InfoItem(
                  icon: Icons.badge,
                  label: 'الرقم الوطني',
                  value: user.nationalId,
                ),
                _InfoItem(
                  icon: Icons.work,
                  label: 'الدور الوظيفي',
                  value: _getRoleName(user.roleId),
                ),
                _InfoItem(
                  icon: Icons.numbers,
                  label: 'معرف المستخدم',
                  value: user.id.toString(),
                ),
              ]),
              const SizedBox(height: 24),
              // حالة التحقق
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        user.isEmailVerified
                            ? Icons.check_circle
                            : Icons.warning,
                        color: user.isEmailVerified
                            ? Colors.green
                            : Colors.orange,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.isEmailVerified
                                  ? 'تم التحقق من البريد الإلكتروني'
                                  : 'لم يتم التحقق من البريد الإلكتروني',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.isEmailVerified
                                  ? 'الحساب موثق ونشط'
                                  : 'يرجى التحقق من البريد الإلكتروني',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<_InfoItem> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Icon(item.icon, color: Colors.blue.shade700, size: 24),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (item.trailing != null) item.trailing!,
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });
}
