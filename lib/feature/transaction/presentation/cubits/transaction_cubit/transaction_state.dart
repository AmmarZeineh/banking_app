part of 'transaction_cubit.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

final class TransactionSuccess extends TransactionState {
  final TransactionType type;
  TransactionSuccess(this.type);
}

final class TransactionFailure extends TransactionState {
  final String errMessage;
  TransactionFailure(this.errMessage);
}
