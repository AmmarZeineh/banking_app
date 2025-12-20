import 'package:banking_app/feature/auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case Test.routeName:
      return MaterialPageRoute(builder: (_) => const Test());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
