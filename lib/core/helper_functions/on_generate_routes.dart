import 'package:banking_app/core/entities/user_entity.dart';
import 'package:banking_app/core/widgets/main_layout.dart';
import 'package:banking_app/feature/account/presentation/views/accounts_view.dart';
import 'package:banking_app/feature/account/presentation/views/create_account_view.dart';
import 'package:banking_app/feature/users/presentation/views/user_details_view.dart';
import 'package:banking_app/feature/users/presentation/views/users_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case MainLayout.routeName:
      return MaterialPageRoute(builder: (_) => const MainLayout());
    case AccountsView.routeName:
      return MaterialPageRoute(builder: (_) => const AccountsView());
    case UsersView.routeName:
      return MaterialPageRoute(builder: (_) => const UsersView());
    case UserDetailsView.routeName:
      final user = settings.arguments as User;
      return MaterialPageRoute(builder: (_) => UserDetailsView(user: user));
    case CreateAccountView.routeName:
      return MaterialPageRoute(builder: (_) => const CreateAccountView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
