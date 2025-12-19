import 'dart:developer';

import 'package:banking_app/core/utils/app_font_styles.dart';
import 'package:banking_app/core/widgets/custom_elevated_button.dart';
import 'package:banking_app/feature/account/presentation/cubits/fetch_accounts_cubit/fetch_accounts_cubit.dart';
import 'package:banking_app/feature/account/presentation/views/widgets/account_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsViewBody extends StatefulWidget {
  const AccountsViewBody({super.key});

  @override
  State<AccountsViewBody> createState() => _AccountsViewBodyState();
}

class _AccountsViewBodyState extends State<AccountsViewBody> {
  @override
  void initState() {
    context.read<FetchAccountsCubit>().fetchAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAccountsCubit, FetchAccountsState>(
      builder: (context, state) {
        if (state is FetchAccountsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FetchAccountsFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.message, style: AppTextStyles.w400_18),
              Center(
                child: CustomElevatedButton(
                  title: 'اعد المحاولة',
                  onPressed: () async {
                    await context.read<FetchAccountsCubit>().fetchAccounts();
                  },
                ),
              ),
            ],
          );
        } else if (state is FetchAccountsSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.accounts.length,
            itemBuilder: (context, index) {
              log(state.accounts.length.toString());
              return AccountCard(account: state.accounts[index]);
            },
          );
        }
        return Center(
          child: Text('لا يوجد بيانات لعرضها', style: AppTextStyles.w500_16),
        );
      },
    );
  }
}
