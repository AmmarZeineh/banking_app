import 'package:banking_app/core/services/get_it_service.dart';
import 'package:banking_app/feature/users/domain/users_repo.dart';
import 'package:banking_app/feature/users/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:banking_app/feature/users/presentation/views/widgets/users_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});
  static const routeName = '/users';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FetchUsersCubit(getIt.get<UsersRepo>()),
        child: UsersViewBody(),
      ),
    );
  }
}
