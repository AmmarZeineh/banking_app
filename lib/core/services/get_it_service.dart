import 'package:banking_app/core/services/api.dart';
import 'package:banking_app/feature/account/data/repos/account_repo_impl.dart';
import 'package:banking_app/feature/account/domain/repo/account_repo.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Core Services
  getIt.registerSingleton<Api>(Api());
  getIt.registerSingleton<AccountRepo>(AccountRepoImpl(getIt.get<Api>()));
}
