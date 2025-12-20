import 'package:banking_app/feature/transaction/domain/entities/transaction_param.dart';

class WithdrawModel {
  final int accountId;
  final int amount;
  final String description;

  const WithdrawModel({
    required this.accountId,
    required this.amount,
    required this.description,
  });

  factory WithdrawModel.fromWithdrawParams(TransactionParams params) {
    return WithdrawModel(
      accountId: params.accountId,
      amount: params.amount,
      description: params.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'amount': amount,
      'toAccountId': 0,
      'description': description,
    };
  }
}
