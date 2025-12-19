import 'package:banking_app/core/utils/app_font_styles.dart';
import 'package:banking_app/core/widgets/custom_elevated_button.dart';
import 'package:banking_app/feature/users/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:banking_app/feature/users/presentation/views/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersViewBody extends StatefulWidget {
  const UsersViewBody({super.key});

  @override
  State<UsersViewBody> createState() => _UsersViewBodyState();
}

class _UsersViewBodyState extends State<UsersViewBody> {
  Color _getRoleColor(int roleId) {
    switch (roleId) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

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
  void initState() {
    context.read<FetchUsersCubit>().fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchUsersCubit, FetchUsersState>(
      builder: (context, state) {
        if (state is FetchUsersSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return UserCard(
                user: state.users[index],
                roleName: _getRoleName(state.users[index].roleId),
                roleColor: _getRoleColor(state.users[index].roleId),
              );
            },
          );
        }
        if (state is FetchUsersLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FetchUsersFailure) {
          return Column(
            crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            children: [
              Text(state.message, style: AppTextStyles.w400_18),
              SizedBox(height: 16),
              CustomElevatedButton(
                title: 'اعد المحاولة',
                onPressed: () async {
                  await context.read<FetchUsersCubit>().fetchUsers();
                },
              ),
              SizedBox(width: double.infinity),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
