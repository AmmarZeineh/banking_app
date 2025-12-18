import 'package:banking_app/core/errors/failure.dart';
import 'package:banking_app/feature/account/domain/entities/create_account_params.dart';
import 'package:dartz/dartz.dart';

abstract class AccountRepo {
  Future<Either<Failure, void>> createAccount({
    required CreateAccountParams createAccountParams,
  });
}
