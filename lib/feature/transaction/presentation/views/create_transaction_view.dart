import 'package:banking_app/core/services/get_it_service.dart';
import 'package:banking_app/feature/transaction/domain/repos/transaction_repo.dart';
import 'package:banking_app/feature/transaction/presentation/cubits/transaction_cubit/transaction_cubit.dart';
import 'package:banking_app/feature/transaction/presentation/views/widgets/create_transaction_view_body.dart';
import 'package:banking_app/feature/users/domain/users_repo.dart';
import 'package:banking_app/feature/users/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransactionView extends StatelessWidget {
  const CreateTransactionView({super.key});
  static const String routeName = "CreateTransactionView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FetchUsersCubit(getIt.get<UsersRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                TransactionsCubit(getIt.get<TransactionRepo>()),
          ),
        ],
        child: const CreateTransactionViewBody(),
      ),
    );
  }
}
