import 'package:banking_app/core/services/get_it_service.dart';
import 'package:banking_app/feature/account/domain/repo/account_repo.dart';
import 'package:banking_app/feature/account/presentation/cubits/create_account_cubit/create_account_cubit.dart';
import 'package:banking_app/feature/account/presentation/cubits/fetch_users_for_create_account_cubit/fetch_users_for_create_account_cubit.dart';
import 'package:banking_app/feature/account/presentation/views/widgets/create_account_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});
  static const String routeName = '/create-account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateAccountCubit(getIt.get<AccountRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                FetchUsersForCreateAccountCubit(getIt.get<AccountRepo>()),
          ),
        ],
        child: CreateAccountViewBody(),
      ),
    );
  }
}
