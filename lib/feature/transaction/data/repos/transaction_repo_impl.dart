import 'package:banking_app/constants.dart';
import 'package:banking_app/core/errors/failure.dart';
import 'package:banking_app/core/services/api.dart';
import 'package:banking_app/feature/transaction/data/models/deposit_model.dart';
import 'package:banking_app/feature/transaction/data/models/transfer_model.dart';
import 'package:banking_app/feature/transaction/data/models/withdraw_model.dart';
import 'package:banking_app/feature/transaction/domain/entities/transaction_param.dart';
import 'package:banking_app/feature/transaction/domain/repos/transaction_repo.dart';
import 'package:dartz/dartz.dart';

class TransactionsRepoImpl implements TransactionRepo {
  final Api _api;

  TransactionsRepoImpl(this._api);

  @override
  Future<Either<Failure, void>> deposit({
    required TransactionParams depositParams,
  }) async {
    try {
      final model = DepositModel.fromDepositParams(depositParams);

      await _api.post(
        url: '$baseUrl/transactions/deposit/${depositParams.userId}',
        body: model.toJson(),
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> withdraw({
    required TransactionParams withdrawParams,
  }) async {
    try {
      final model = WithdrawModel.fromWithdrawParams(withdrawParams);

      await _api.post(
        url: '$baseUrl/transactions/withdraw/${withdrawParams.userId}',
        body: model.toJson(),
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> transfer({
    required TransactionParams transferParams,
  }) async {
    try {
      final model = TransferModel.fromTransferParams(transferParams);

      await _api.post(
        url: '$baseUrl/transactions/transfer/${transferParams.userId}',
        body: model.toJson(),
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
