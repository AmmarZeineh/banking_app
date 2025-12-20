import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/errors/failure.dart';
import 'package:banking_app/feature/account/domain/entities/account_entity.dart';
import 'package:banking_app/feature/account/domain/entities/create_account_params.dart';
import 'package:dartz/dartz.dart';

abstract class AccountRepo {
  Future<Either<Failure, void>> createAccount({
    required CreateAccountParams createAccountParams,
  });
  Future<Either<Failure, List<User>>> listAllUsers();
  Future<Either<Failure, List<Account>>> fetchAccounts();
}
