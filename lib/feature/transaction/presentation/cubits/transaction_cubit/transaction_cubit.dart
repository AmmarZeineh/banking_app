import 'package:banking_app/core/errors/failure.dart';
import 'package:banking_app/enums/transaction_type.dart';
import 'package:banking_app/feature/transaction/domain/entities/transaction_param.dart';
import 'package:banking_app/feature/transaction/domain/repos/transaction_repo.dart';
import 'package:banking_app/feature/transaction/presentation/views/widgets/create_transaction_view_body.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

part 'transaction_state.dart';

class TransactionsCubit extends Cubit<TransactionState> {
  final TransactionRepo repo;

  TransactionsCubit(this.repo) : super(TransactionInitial());
  Future<void> createTransaction({
    required TransactionType type,
    required int userId,
    required int accountId,
    int? toAccountId,
    required int amount,
    required String description,
  }) async {
    emit(TransactionLoading());

    final params = TransactionParams(
      userId: userId,
      accountId: accountId,
      toAccountId: toAccountId,
      amount: amount,
      description: description,
    );

    late Either<Failure, void> result;

    switch (type) {
      case TransactionType.deposit:
        result = await repo.deposit(depositParams: params);
        break;
      case TransactionType.withdraw:
        result = await repo.withdraw(withdrawParams: params);
        break;
      case TransactionType.transfer:
        result = await repo.transfer(transferParams: params);
        break;
    }

    result.fold(
      (l) => emit(TransactionFailure(l.message)),
      (r) => emit(TransactionSuccess(type)),
    );
  }
}
