import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/clients/presentation/pages/clients_page.dart';
import 'package:quantify/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:quantify/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:quantify/features/drawer/presentation/pages/custom_drawer.dart';
import 'package:quantify/features/main/presentation/blocs/drawer_cubit.dart';
import 'package:quantify/features/profile/pages/profile_page.dart';
import 'package:quantify/features/settings/pages/settings_page.dart';
import 'package:quantify/features/statistics/pages/statistics_page.dart';
import 'package:quantify/features/support/pages/support_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController _lottieController;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    _lottieController = AnimationController(vsync: this);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void toggleLottieAnimation() {
    final drawerCubit = BlocProvider.of<DrawerCubit>(context);
    if (drawerCubit.state) {
      _lottieController.reverse();
      _animationController.reverse();
    } else {
      _lottieController.forward();
      _animationController.forward();
    }
    setState(() {
      drawerCubit.changeDrawerState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = context.deviceSize.height;
    final width = context.deviceSize.width;
    return BlocBuilder<DrawerCubit, bool>(builder: (context, state) {
      return BlocBuilder<DrawerItemCubit, int>(builder: (context, pageIndex) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                width: width,
                height: height,
                child: CustomDrawer(
                  onItemClicked: toggleLottieAnimation,
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(animation.value - 30 * animation.value * pi / 180),
                child: Transform.translate(
                  offset: Offset(animation.value * 288, 0),
                  child: Transform.scale(
                    scale: scaleAnimation.value,
                    child: Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(state ? 20 : 0),
                        border: Border.all(
                          width: state ? 1 : 0.0,
                          color: context.brightness == Brightness.light
                              ? AppColors.bgColor
                              : AppColors.hintColor,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: pages[pageIndex],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: state ? 80 : 40,
                left: state ? 260 : 10,
                child: GestureDetector(
                  onTap: toggleLottieAnimation,
                  child: Lottie.asset(
                    'assets/lottie/drawer.json',
                    controller: _lottieController,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    repeat: false,
                    onLoaded: (composition) {
                      _lottieController.duration = composition.duration;
                    },
                  ),
                ),
              )
            ],
          ),
        );
      });
    });
  }
}

List<Widget> pages = [
  const DashboardPage(),
  const ClientsPage(),
  const StatisticsPage(),
  const ProfilePage(),
  const SettingsPage(),
  const SupportPage(),
];
