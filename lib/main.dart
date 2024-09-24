import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quantify/core/configs/app_router.dart';
import 'package:quantify/core/theme/app_theme.dart';
import 'package:quantify/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:quantify/features/main/presentation/blocs/drawer_cubit.dart';
import 'package:quantify/features/onboarding/presentation/blocs/on_boarding_cubit.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_bloc.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_event.dart';
import 'package:quantify/shared/thememode/theme_cubit.dart';
import 'package:path_provider/path_provider.dart';

import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  await initializeDependencies();

  final appRouter = AppRouter();
  runApp(MainApp(
    appRouter: appRouter,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => OnBoardingCubit()..checkOnBoardingStatus(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ShopBloc()..add(GetShopData()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => DrawerItemCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => DrawerCubit(),
          lazy: false,
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, mode) {
          return MaterialApp(
            title: 'QUANTIFY',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            themeMode: mode,
            darkTheme: AppTheme.darkTheme,
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
