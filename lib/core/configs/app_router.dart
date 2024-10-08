import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quantify/features/clients/presentation/pages/add_client_page.dart';
import 'package:quantify/features/dashboard/presentation/pages/add_ticket_screen.dart';
import 'package:quantify/features/main/presentation/pages/main_page.dart';
import 'package:quantify/features/onboarding/presentation/onboarding_page.dart';
import 'package:quantify/features/shop_data/presentation/pages/shop_data_page.dart';
import 'package:quantify/shared/pages/initial_page.dart';

class AppRouter {
  static const initialPage = '/';
  static const addTicketScreen = '/add_ticket';
  static const mainPage = '/main';
  static const onBoardingPage = '/on_boarding';
  static const shopDataPage = '/shop_data';
  static const addClientPage = '/add_client';

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialPage:
        return MaterialPageRoute(
          builder: (_) => const InitialPage(),
        );
      case onBoardingPage:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );
      case shopDataPage:
        return MaterialPageRoute(
          builder: (_) => const ShopDataPage(),
        );

      case mainPage:
        return CupertinoPageRoute(
          builder: (_) => const MainPage(),
        );
      case addTicketScreen:
        return CupertinoPageRoute(
          builder: (_) => const AddTicketScreen(),
        );
      case addClientPage:
        return CupertinoPageRoute(
          builder: (_) => const AddClientPage(),
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
