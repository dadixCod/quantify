import 'package:quantify/core/constants/app_vectors.dart';
import 'package:rive/rive.dart';

class DrawerItem {
  final String title;
  final String icon;
  DrawerItem({
    required this.title,
    required this.icon,
  });
}

List<DrawerItem> drawerItems = [
  DrawerItem(title: 'Dashboard', icon: AppVectors.dashboard),
  DrawerItem(title: 'Clients', icon: AppVectors.clients),
  DrawerItem(title: 'Statistics', icon: AppVectors.statistics),
  DrawerItem(title: 'Profile', icon: AppVectors.profile),
  DrawerItem(title: 'Settings', icon: AppVectors.settings),
  DrawerItem(title: 'Support', icon: AppVectors.support),
];

class RiveItem {
  final String artboard, stateMachine, title, src;
  late SMIBool? input;
  RiveItem(
    this.src,
    {
      required this.artboard,
      required this.stateMachine,
      required this.title,
      this.input
    }
  );
  set setInput(SMIBool value) => input = value;
}

List<RiveItem> riveItems = [
  RiveItem(
    'assets/rive/dashboard.riv',
    artboard: 'DASHBOARD',
    stateMachine: 'DASHBOARD_Interactivity',
    title: 'Dashboard',
  ),
  RiveItem(
    'assets/rive/clients.riv',
    artboard: 'CLIENTS',
    stateMachine: 'CLIENTS_Interactivity',
    title: 'Clients',
  ),
  RiveItem(
    'assets/rive/statistics.riv',
    artboard: 'STATISTICS',
    stateMachine: 'STATISTICS_Interactivity',
    title: 'Statistics',
  ),
  RiveItem(
    'assets/rive/profile.riv',
    artboard: 'PROFILE',
    stateMachine: 'PROFILE_Interactivity',
    title: 'Profile',
  ),
  RiveItem(
    'assets/rive/settings.riv',
    artboard: 'SETTINGS',
    stateMachine: 'SETTINGS_Interactivity',
    title: 'Settings',
  ),
  RiveItem(
    'assets/rive/support.riv',
    artboard: 'SUPPORT',
    stateMachine: 'SUPPORT_Interactivity',
    title: 'Support',
  ),
];
