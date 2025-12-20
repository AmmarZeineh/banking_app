part of 'fetch_accounts_cubit.dart';

@immutable
sealed class FetchAccountsState {}

final class FetchAccountsInitial extends FetchAccountsState {}

final class FetchAccountsLoading extends FetchAccountsState {}

final class FetchAccountsSuccess extends FetchAccountsState {
  final List<Account> accounts;

  FetchAccountsSuccess(this.accounts);
}

final class FetchAccountsFailure extends FetchAccountsState {
  final String message;

  FetchAccountsFailure(this.message);
}
