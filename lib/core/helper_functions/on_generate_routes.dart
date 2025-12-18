import 'package:banking_app/feature/account/presentation/views/create_account_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case CreateAccountView.routeName:
      return MaterialPageRoute(builder: (_) => const CreateAccountView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
