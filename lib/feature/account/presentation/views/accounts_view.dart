import 'package:banking_app/core/services/get_it_service.dart';
import 'package:banking_app/feature/account/domain/repo/account_repo.dart';
import 'package:banking_app/feature/account/presentation/cubits/fetch_accounts_cubit/fetch_accounts_cubit.dart';
import 'package:banking_app/feature/account/presentation/views/widgets/accounts_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key});
  static const String routeName = '/accounts';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAccountsCubit(getIt.get<AccountRepo>()),
      child: AccountsViewBody(),
    );
  }
}
