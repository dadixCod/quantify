import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quantify/features/main/presentation/main_screen.dart';
import 'package:quantify/features/onboarding/presentation/onboarding_page.dart';
import 'package:quantify/features/shop_data/presentation/pages/shop_data_page.dart';
import 'package:quantify/shared/pages/initial_page.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const InitialPage(),
        );
      case '/on_boarding':
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );

      case '/main':
        return CupertinoPageRoute(
          builder: (_) => const MainScreen(),
        );
      case '/shop_data':
        return CupertinoPageRoute(
          builder: (_) => const ShopDataPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No route found'),
            ),
          ),
        );
    }
  }
}
