import 'package:banking_app/feature/account/domain/entities/create_account_params.dart';
import 'package:banking_app/feature/account/domain/repo/account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit(this._accountRepo) : super(CreateAccountInitial());
  final AccountRepo _accountRepo;

  Future<void> createAccount({
    required CreateAccountParams createAccountParams,
  }) async {
    emit(CreateAccountLoading());
    final result = await _accountRepo.createAccount(
      createAccountParams: createAccountParams,
    );
    result.fold(
      (l) => emit(CreateAccountFailure(l.message)),
      (r) => emit(CreateAccountSuccess()),
    );
  }
}
