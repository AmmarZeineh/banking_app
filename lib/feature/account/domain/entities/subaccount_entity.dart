class SubAccount {
  final int id;
  final String accountNumber;
  final String accountLabel;
  final String accountType;
  final int balance;
  final String currency;
  final bool isComposite;
  final int? parentAccountId;

  const SubAccount({
    required this.id,
    required this.accountNumber,
    required this.accountLabel,
    required this.accountType,
    required this.balance,
    required this.currency,
    required this.isComposite,
    this.parentAccountId,
  });
}
