import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/feature/account/domain/entities/subaccount_entity.dart';

import 'parent_account_entity.dart';

class Account {
  final int id;
  final String accountType;
  final String accountNumber;
  final int balance;
  final bool isComposite;
  final String currency;
  final int overdraftLimit;
  final int interestRate;
  final String accountLabel;

  final User user;
  final ParentAccount? parentAccount;
  final List<SubAccount> subAccounts;

  const Account({
    required this.id,
    required this.accountType,
    required this.accountNumber,
    required this.balance,
    required this.isComposite,
    required this.currency,
    required this.overdraftLimit,
    required this.interestRate,
    required this.accountLabel,
    required this.user,
    this.parentAccount,
    this.subAccounts = const [],
  });
}
