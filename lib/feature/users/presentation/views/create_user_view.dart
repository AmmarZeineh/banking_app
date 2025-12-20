import 'package:banking_app/core/services/get_it_service.dart';
import 'package:banking_app/feature/users/domain/repos/users_repo.dart';
import 'package:banking_app/feature/users/presentation/cubits/create_user_cubit/create_user_cubit.dart';
import 'package:banking_app/feature/users/presentation/views/widgets/create_user_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateUserView extends StatelessWidget {
  const CreateUserView({super.key});
  static const routeName = '/create-user';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUserCubit(getIt.get<UsersRepo>()),
      child: CreateUserViewBody(),
    );
  }
}
