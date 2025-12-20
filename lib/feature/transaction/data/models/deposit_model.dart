import 'package:banking_app/feature/transaction/domain/entities/transaction_param.dart';

class DepositModel {
  final int amount;
  final int accountId;
  final String description;

  const DepositModel({
    required this.amount,
    required this.accountId,
    required this.description,
  });

  /// Mapper: Params → Model
  factory DepositModel.fromDepositParams(TransactionParams params) {
    return DepositModel(
      amount: params.amount,
      accountId: params.accountId,
      description: params.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'accountId': accountId,
      'toAccountId': 0,
      'description': description,
    };
  }
}
