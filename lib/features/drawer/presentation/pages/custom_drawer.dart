import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantify/core/configs/app_router.dart';

import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/core/utils/rive_utils.dart';
import 'package:quantify/features/drawer/data/drawer_item.dart';
import 'package:quantify/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:quantify/features/drawer/presentation/widgets/drawer_container.dart';
import 'package:quantify/features/main/presentation/blocs/drawer_cubit.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_bloc.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_event.dart';
import 'package:quantify/shared/widgets/dialogs.dart';
import 'package:rive/rive.dart';

class CustomDrawer extends StatefulWidget {
  final VoidCallback onItemClicked;
  const CustomDrawer({super.key, required this.onItemClicked});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late SMIBool active;

  @override
  Widget build(BuildContext context) {
    final width = context.deviceSize.width;
    final height = context.deviceSize.height;
    final isLight = context.brightness == Brightness.light;

    return BlocBuilder<DrawerItemCubit, int>(builder: (context, state) {
      return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        decoration: BoxDecoration(
          color: isLight ? AppColors.maincolor : AppColors.darkBgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'QUANTIFY',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 15,
                    width: width,
                    child: Divider(
                      color: isLight
                          ? AppColors.borderDarkColor
                          : AppColors.darkContainer,
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: drawerItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.read<DrawerItemCubit>().changeIndex(index);
                      Future.delayed(const Duration(milliseconds: 300), () {
                        widget.onItemClicked();
                      });
                    },
                    child: DrawerContainer(
                      title: drawerItems[index].title,
                      icon: drawerItems[index].icon,
                      isSelected: index == state,
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                final response = await confirmationDialog(
                  context,
                  title: 'Logout',
                  content: 'Are you sure you want to logout?',
                );
                if (response == true) {
                  context.read<DrawerCubit>().changeDrawerState();
                  context.read<ShopBloc>().add(LogoutFromShop());
                  context.navigator
                      .pushReplacementNamed(AppRouter.shopDataPage);
                }
              },
              child: const DrawerContainer(
                title: 'Logout',
                icon: AppVectors.logout,
                isSelected: false,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class RiveContainer extends StatelessWidget {
  const RiveContainer({
    super.key,
    required this.riveItem,
    required this.isSelected,
  });
  final RiveItem riveItem;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 50,
          width: isSelected ? 240 : 0,
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Container(
          height: 50,
          width: 240,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: RiveAnimation.asset(
                  riveItem.src,
                  artboard: riveItem.artboard,
                  onInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(
                      artboard,
                      stateMachine: riveItem.stateMachine,
                    );
                    riveItem.input = controller.findSMI('active') as SMIBool;
                  },
                ),
              ),
              const SizedBox(width: 20),
              Text(
                riveItem.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
