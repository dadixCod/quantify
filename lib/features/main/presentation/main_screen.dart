import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_bloc.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoaded) {
            return Center(
              child: Text(state.shop.shopName),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
