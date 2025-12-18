class CreateAccountParams {
  final int userId;
  final String accountType;
  final String currency;
  final int overdraftLimit;
  final int interestRate;
  final String accountLabel;
  final int? parentAccountId;

  const CreateAccountParams({
    required this.userId,
    required this.accountType,
    required this.currency,
    required this.overdraftLimit,
    required this.interestRate,
    required this.accountLabel,
    this.parentAccountId,
  });
}
