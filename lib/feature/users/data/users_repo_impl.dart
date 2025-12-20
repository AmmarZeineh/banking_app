import 'package:banking_app/constants.dart';
import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/errors/failure.dart';
import 'package:banking_app/core/models/user_model.dart';
import 'package:banking_app/core/services/api.dart';
import 'package:banking_app/feature/users/domain/users_repo.dart';
import 'package:dartz/dartz.dart';

class UsersRepoImpl implements UsersRepo {
  final Api _api;

  UsersRepoImpl(this._api);
  @override
  Future<Either<Failure, List<User>>> listAllUsers() async {
    try {
      final response = await _api.get(url: '$baseUrl/user?skip=0&limit=10');

      final List<dynamic> rawUsers = response['data'] ?? [];

      final users = rawUsers
          .map((u) => UserModel.fromJson(u).toEntity())
          .toList();

      return Right(users);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await _api.delete(url: '$baseUrl/user/$id');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
