import 'package:banking_app/feature/users/domain/entities/create_user_params.dart';
import 'package:banking_app/feature/users/domain/repos/users_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit(this._usersRepo) : super(CreateUserInitial());
  final UsersRepo _usersRepo;

  Future<void> createUser(CreateUserParams createUserParams) async {
    emit(CreateUserLoading());
    final result = await _usersRepo.createUser(createUserParams);
    result.fold(
      (l) => emit(CreateUserFailure(l.message)),
      (r) => emit(CreateUserSuccess()),
    );
  }
}
