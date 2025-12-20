part of 'create_user_cubit.dart';

@immutable
sealed class CreateUserState {}

final class CreateUserInitial extends CreateUserState {}

final class CreateUserLoading extends CreateUserState {}

final class CreateUserFailure extends CreateUserState {
  final String message;

  CreateUserFailure(this.message);
}

final class CreateUserSuccess extends CreateUserState {}
