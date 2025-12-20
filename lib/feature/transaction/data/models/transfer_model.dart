import 'package:banking_app/feature/transaction/domain/entities/transaction_param.dart';

class TransferModel {
  final int fromAccountId;
  final int toAccountId;
  final int amount;
  final String description;

  const TransferModel({
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.description,
  });

  factory TransferModel.fromTransferParams(TransactionParams params) {
    if (params.toAccountId == null) {
      throw ArgumentError('toAccountId is required for transfer');
    }
    return TransferModel(
      fromAccountId: params.accountId,
      toAccountId: params.toAccountId!,
      amount: params.amount,
      description: params.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': fromAccountId,
      'toAccountId': toAccountId,
      'amount': amount,
      'description': description,
    };
  }
}
