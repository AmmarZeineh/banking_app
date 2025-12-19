import 'package:banking_app/feature/account/domain/entities/subaccount_entity.dart';

class SubAccountModel {
  int? id;
  String? accountNumber;
  String? accountLabel;
  String? accountType;
  int? balance;
  bool? isComposite;
  int? parentAccountId;
  String? currency;
  String? transitionsState;
  int? overdraftLimit;
  int? interestRate;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubAccountModel({
    this.id,
    this.accountNumber,
    this.accountLabel,
    this.accountType,
    this.balance,
    this.isComposite,
    this.parentAccountId,
    this.currency,
    this.transitionsState,
    this.overdraftLimit,
    this.interestRate,
    this.createdAt,
    this.updatedAt,
  });

  factory SubAccountModel.fromJson(Map<String, dynamic> json) =>
      SubAccountModel(
        id: json['id'] as int?,
        accountNumber: json['accountNumber'] as String?,
        accountLabel: json['accountLabel'] as String?,
        accountType: json['accountType'] as String?,
        balance: json['balance'] as int?,
        isComposite: json['isComposite'] as bool?,
        parentAccountId: json['parentAccountId'] as int?,
        currency: json['currency'] as String?,
        transitionsState: json['transitionsState'] as String?,
        overdraftLimit: json['overdraftLimit'] as int?,
        interestRate: json['interestRate'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'accountNumber': accountNumber,
    'accountLabel': accountLabel,
    'accountType': accountType,
    'balance': balance,
    'isComposite': isComposite,
    'parentAccountId': parentAccountId,
    'currency': currency,
    'transitionsState': transitionsState,
    'overdraftLimit': overdraftLimit,
    'interestRate': interestRate,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  SubAccount toEntity() => SubAccount(
    id: id!,
    accountNumber: accountNumber!,
    accountLabel: accountLabel!,
    accountType: accountType!,
    balance: balance!,
    currency: currency!,
    isComposite: isComposite!,
    parentAccountId: parentAccountId!,
  );
}
