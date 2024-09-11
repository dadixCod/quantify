import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/features/main/presentation/main_screen.dart';
import 'package:quantify/features/onboarding/presentation/blocs/on_boarding_cubit.dart';
import 'package:quantify/features/onboarding/presentation/onboarding_page.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_bloc.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_state.dart';
import 'package:quantify/features/shop_data/presentation/pages/shop_data_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnBoardingCubit, bool>(
        builder: (context, state) {
          if (state == true) {
            return BlocBuilder<ShopBloc, ShopState>(
              builder: (context, state) {
                if (state is ShopNull) {
                  return const ShopDataPage();
                } else if (state is ShopLoaded) {
                  return const MainScreen();
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else {
            return const OnboardingPage();
          }
        },
      ),
    );
  }
}
