part of 'fetch_users_cubit.dart';

@immutable
sealed class FetchUsersState {}

final class FetchUsersInitial extends FetchUsersState {}

final class FetchUsersLoading extends FetchUsersState {}

final class FetchUsersSuccess extends FetchUsersState {
  final List<User> users;

  FetchUsersSuccess(this.users);
}

final class FetchUsersFailure extends FetchUsersState {
  final String message;

  FetchUsersFailure(this.message);
}
