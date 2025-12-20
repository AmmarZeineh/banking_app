import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/feature/users/domain/users_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_users_state.dart';

class FetchUsersCubit extends Cubit<FetchUsersState> {
  FetchUsersCubit(this._usersRepo) : super(FetchUsersInitial());
  final UsersRepo _usersRepo;

  Future<void> fetchUsers() async {
    emit(FetchUsersLoading());
    final result = await _usersRepo.listAllUsers();
    result.fold(
      (l) => emit(FetchUsersFailure(l.message)),
      (r) => emit(FetchUsersSuccess(r)),
    );
  }
}
