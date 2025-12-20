class TransactionParams {
  final int userId;
  final int amount;
  final int accountId;
  final String description;
  final int? toAccountId;

  const TransactionParams({
    required this.amount,
    required this.accountId,
    required this.description,
    this.toAccountId, required this.userId,
  });
}
