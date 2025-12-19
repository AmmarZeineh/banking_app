import 'package:banking_app/feature/account/domain/entities/account_entity.dart';
import 'package:banking_app/feature/account/domain/entities/subaccount_entity.dart';
import 'package:flutter/material.dart';

class AccountDetailsPage extends StatelessWidget {
  final Account account;

  const AccountDetailsPage({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الحساب'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection('معلومات الحساب', [
              _InfoRow('رقم الحساب', account.accountNumber),
              _InfoRow('نوع الحساب', account.accountType),
              _InfoRow('اسم الحساب', account.accountLabel),
              _InfoRow('العملة', account.currency),
              _InfoRow('الرصيد', '${account.balance} ${account.currency}'),
              _InfoRow(
                'حد السحب على المكشوف',
                '${account.overdraftLimit} ${account.currency}',
              ),
              _InfoRow('معدل الفائدة', '${account.interestRate}%'),
            ]),
            const SizedBox(height: 24),
            _buildInfoSection('معلومات المستخدم', [
              _InfoRow('الاسم', account.user.name),
              _InfoRow('البريد الإلكتروني', account.user.email),
            ]),

            // عرض الحسابات الفرعية إذا موجودة
            if (account.subAccounts.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'الحسابات الفرعية',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              // استخدام Column.children بدل ListView.builder
              ...account.subAccounts.map((subAccount) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildInfoSection('معلومات الحساب الفرعي', [
                    _InfoRow('رقم الحساب', subAccount.accountNumber),
                    _InfoRow('نوع الحساب', subAccount.accountType),
                    _InfoRow('اسم الحساب', subAccount.accountLabel),
                    _InfoRow('العملة', subAccount.currency),
                    _InfoRow(
                      'الرصيد',
                      '${subAccount.balance} ${subAccount.currency}',
                    ),
                  ]),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<_InfoRow> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: rows.map((row) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        row.label,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        row.value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow {
  final String label;
  final String value;
  _InfoRow(this.label, this.value);
}

// بطاقة الحساب الفرعي
class SubAccountCard extends StatelessWidget {
  final SubAccount subAccount;

  const SubAccountCard({super.key, required this.subAccount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(Icons.account_balance, color: Colors.blue.shade700),
        ),
        title: Text(subAccount.accountLabel),
        subtitle: Text(subAccount.accountNumber),
        trailing: Text(
          '${subAccount.balance} ${subAccount.currency}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
