class ParentAccount {
  final int id;
  final String accountNumber;
  final String accountLabel;
  final String accountType;
  final bool isComposite;

  const ParentAccount({
    required this.id,
    required this.accountNumber,
    required this.accountLabel,
    required this.accountType,
    required this.isComposite,
  });
}
