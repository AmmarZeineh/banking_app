import 'package:banking_app/core/errors/failure.dart';
import 'package:banking_app/feature/transaction/domain/entities/transaction_param.dart';
import 'package:dartz/dartz.dart';

abstract class TransactionRepo {
  Future<Either<Failure, void>> deposit({
    required TransactionParams depositParams,
  });
  Future<Either<Failure, void>> withdraw({
    required TransactionParams withdrawParams,
  });
  Future<Either<Failure, void>> transfer({
    required TransactionParams transferParams,
  });
}
