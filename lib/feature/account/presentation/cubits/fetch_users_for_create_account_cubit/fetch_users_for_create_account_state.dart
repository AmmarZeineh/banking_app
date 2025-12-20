part of 'fetch_users_for_create_account_cubit.dart';

@immutable
sealed class FetchUsersForCreateAccountState {}

final class FetchUsersForCreateAccountInitial
    extends FetchUsersForCreateAccountState {}

final class FetchUsersForCreateAccountFailure
    extends FetchUsersForCreateAccountState {
  final String message;

  FetchUsersForCreateAccountFailure(this.message);
}

final class FetchUsersForCreateAccountLoading
    extends FetchUsersForCreateAccountState {}

final class FetchUsersForCreateAccountSuccess
    extends FetchUsersForCreateAccountState {
  final List<User> usersList;

  FetchUsersForCreateAccountSuccess(this.usersList);
}
