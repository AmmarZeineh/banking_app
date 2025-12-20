import 'package:banking_app/core/services/api.dart';
import 'package:banking_app/feature/account/data/repos/account_repo_impl.dart';
import 'package:banking_app/feature/account/domain/repo/account_repo.dart';
import 'package:banking_app/feature/transaction/data/repos/transaction_repo_impl.dart';
import 'package:banking_app/feature/transaction/domain/repos/transaction_repo.dart';
import 'package:banking_app/feature/users/data/users_repo_impl.dart';
import 'package:banking_app/feature/users/domain/users_repo.dart';
import 'package:banking_app/feature/auth/data/repos/auth_repo_impl.dart';
import 'package:banking_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Core Services
  getIt.registerSingleton<Api>(Api());
  getIt.registerSingleton<AccountRepo>(AccountRepoImpl(getIt.get<Api>()));
  getIt.registerSingleton<UsersRepo>(UsersRepoImpl(getIt.get<Api>()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<Api>()));
  getIt.registerSingleton<TransactionRepo>(
    TransactionsRepoImpl(getIt.get<Api>()),
  );
}
