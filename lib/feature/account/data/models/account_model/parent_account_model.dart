class ParentAccountModel {
  int? id;
  String? accountNumber;
  String? accountLabel;
  String? accountType;
  bool? isComposite;

  ParentAccountModel({
    this.id,
    this.accountNumber,
    this.accountLabel,
    this.accountType,
    this.isComposite,
  });

  factory ParentAccountModel.fromJson(Map<String, dynamic> json) =>
      ParentAccountModel(
        id: json['id'] as int?,
        accountNumber: json['accountNumber'] as String?,
        accountLabel: json['accountLabel'] as String?,
        accountType: json['accountType'] as String?,
        isComposite: json['isComposite'] as bool?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'accountNumber': accountNumber,
    'accountLabel': accountLabel,
    'accountType': accountType,
    'isComposite': isComposite,
  };
}
