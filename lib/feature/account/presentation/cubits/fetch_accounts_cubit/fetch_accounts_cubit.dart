import 'package:banking_app/feature/account/domain/entities/account_entity.dart';
import 'package:banking_app/feature/account/domain/repo/account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_accounts_state.dart';

class FetchAccountsCubit extends Cubit<FetchAccountsState> {
  FetchAccountsCubit(this._accountRepo) : super(FetchAccountsInitial());
  final AccountRepo _accountRepo;

  Future<void> fetchAccounts() async {
    emit(FetchAccountsLoading());
    var result = await _accountRepo.fetchAccounts();
    result.fold(
      (l) => emit(FetchAccountsFailure(l.message)),
      (accounts) => emit(FetchAccountsSuccess(accounts)),
    );
  }
}
