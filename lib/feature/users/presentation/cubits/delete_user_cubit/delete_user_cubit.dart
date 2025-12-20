import 'package:banking_app/feature/users/domain/repos/users_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit(this._usersRepo) : super(DeleteUserInitial());
  final UsersRepo _usersRepo;

  Future<void> deleteUser(String id) async {
    emit(DeleteUserLoading());
    final result = await _usersRepo.deleteUser(id);
    result.fold(
      (l) => emit(DeleteUserFailure(l.message)),
      (r) => emit(DeleteUserSuccess()),
    );
  }
}
