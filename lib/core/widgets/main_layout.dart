import 'package:banking_app/core/widgets/dashboard_sidebar.dart';
import 'package:banking_app/feature/account/presentation/views/accounts_view.dart';
import 'package:banking_app/feature/account/presentation/views/create_account_view.dart';
import 'package:banking_app/feature/users/presentation/views/users_view.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  static const routeName = 'mainLayout';

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CreateAccountView(),
    AccountsView(),
    UsersView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DashboardSidebar(
            currentIndex: _currentIndex,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Expanded(
            child: IndexedStack(index: _currentIndex, children: _pages),
          ),
        ],
      ),
    );
  }
}
