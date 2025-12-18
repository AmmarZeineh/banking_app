import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/feature/account/domain/repo/account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'fetch_users_for_create_account_state.dart';

class FetchUsersForCreateAccountCubit
    extends Cubit<FetchUsersForCreateAccountState> {
  FetchUsersForCreateAccountCubit(this._accountRepo)
    : super(FetchUsersForCreateAccountInitial());

  final AccountRepo _accountRepo;

  Future<void> fetchUsers() async {
    emit(FetchUsersForCreateAccountLoading());
    var result = await _accountRepo.listAllUsers();
    result.fold(
      (l) => emit(FetchUsersForCreateAccountFailure(l.message)),
      (users) => emit(FetchUsersForCreateAccountSuccess(users)),
    );
  }
}
