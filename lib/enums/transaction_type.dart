enum TransactionType {
  deposit,
  withdraw,
  transfer,
}


extension TransactionTypeX on TransactionType {
  String get label {
    switch (this) {
      case TransactionType.deposit:
        return 'إيداع';
      case TransactionType.withdraw:
        return 'سحب';
      case TransactionType.transfer:
        return 'تحويل';
    }
  }
}

