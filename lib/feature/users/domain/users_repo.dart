import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UsersRepo {
  Future<Either<Failure, List<User>>> listAllUsers();
  Future<Either<Failure, void>> deleteUser(String id);
}
