import 'package:banking_app/core/models/user_model.dart';
import 'package:banking_app/feature/account/domain/entities/create_account_params.dart';

import 'parent_account_model.dart';
import 'sub_account.dart';

class AccountModel {
  int? id;
  String? accountType;
  String? accountNumber;
  int? balance;
  bool? isComposite;
  int? userId;
  String? transitionsState;
  String? statusReason;
  String? currency;
  int? overdraftLimit;
  int? parentAccountId;
  String? accountLabel;
  int? interestRate;
  DateTime? lastInterestAppliedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  ParentAccountModel? parentAccount;
  List<SubAccountModel>? subAccounts;
  UserModel? user;

  AccountModel({
    this.id,
    this.accountType,
    this.accountNumber,
    this.balance,
    this.isComposite,
    this.userId,
    this.transitionsState,
    this.statusReason,
    this.currency,
    this.overdraftLimit,
    this.parentAccountId,
    this.accountLabel,
    this.interestRate,
    this.lastInterestAppliedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.parentAccount,
    this.subAccounts,
    this.user,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
    id: json['id'] as int?,
    accountType: json['accountType'] as String?,
    accountNumber: json['accountNumber'] as String?,
    balance: json['balance'] as int?,
    isComposite: json['isComposite'] as bool?,
    userId: json['userId'] as int?,
    transitionsState: json['transitionsState'] as String?,
    statusReason: json['statusReason'] as String?,
    currency: json['currency'] as String?,
    overdraftLimit: json['overdraftLimit'] as int?,
    parentAccountId: json['parentAccountId'] as int?,
    accountLabel: json['accountLabel'] as String?,
    interestRate: json['interestRate'] as int?,
    lastInterestAppliedAt: json['lastInterestAppliedAt'] == null
        ? null
        : DateTime.parse(json['lastInterestAppliedAt'] as String),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    deletedAt: json['deletedAt'] == null
        ? null
        : DateTime.parse(json['deletedAt'] as String),
    parentAccount: json['parentAccount'] == null
        ? null
        : ParentAccountModel.fromJson(
            json['parentAccount'] as Map<String, dynamic>,
          ),
    subAccounts: (json['subAccounts'] as List<dynamic>?)
        ?.map((e) => SubAccountModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );

  AccountModel.fromAccountParams(CreateAccountParams createAccountParams) {
    accountType = createAccountParams.accountType;
    userId = createAccountParams.userId;
    currency = createAccountParams.currency;
    overdraftLimit = createAccountParams.overdraftLimit;
    accountLabel = createAccountParams.accountLabel;
    interestRate = createAccountParams.interestRate;
  }

  Map<String, dynamic> toJson() => {
    'accountType': accountType,
    'userId': userId,
    'currency': currency,
    'overdraftLimit': overdraftLimit,
    'parentAccountId': parentAccountId,
    'accountLabel': accountLabel,
    'interestRate': interestRate,
  };
}
