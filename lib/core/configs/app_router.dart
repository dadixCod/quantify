import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quantify/features/clients/presentation/pages/add_client_page.dart';
import 'package:quantify/features/dashboard/domain/entity/ticket.dart';
import 'package:quantify/features/dashboard/presentation/pages/add_edit_ticket_screen.dart';
import 'package:quantify/features/main/presentation/pages/main_page.dart';
import 'package:quantify/features/notifications/presentation/pages/notifications_page.dart';
import 'package:quantify/features/onboarding/presentation/onboarding_page.dart';
import 'package:quantify/features/shop_data/presentation/pages/shop_data_page.dart';
import 'package:quantify/shared/pages/initial_page.dart';

class AppRouter {
  static const initialPage = '/';
  static const addEditTicketScreen = '/add_ticket';
  static const mainPage = '/main';
  static const onBoardingPage = '/on_boarding';
  static const shopDataPage = '/shop_data';
  static const addClientPage = '/add_client';
  static const notificationsPage = '/notifications';

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
      case addEditTicketScreen:
        {
          final selectedTicket = settings.arguments as TicketEntity?;
          return CupertinoPageRoute(
            builder: (_) => AddEditTicketScreen(
              selectedTicket: selectedTicket,
            ),
          );
        }

      case addClientPage:
        return CupertinoPageRoute(
          builder: (_) => const AddClientPage(),
        );
      case notificationsPage:
        return CupertinoPageRoute(
          builder: (_) => const NotificationsPage(),
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
