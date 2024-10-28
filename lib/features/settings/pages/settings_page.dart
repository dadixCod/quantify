import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quantify/core/configs/app_router.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_bloc.dart';
import 'package:quantify/features/shop_data/presentation/blocs/shop_event.dart';
import 'package:quantify/shared/widgets/dialogs.dart';
import 'package:quantify/shared/widgets/simple_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifcation = false;
  @override
  Widget build(BuildContext context) {
    final height = context.deviceSize.height;
    final width = context.deviceSize.width;
    final isLight = context.brightness == Brightness.light;
    return Scaffold(
        body: SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          SimpleAppBar(
            height: height,
            width: width,
            title: 'Settings',
            trailing: const SizedBox(width: 50),
          ),
          const SizedBox(height: 30),
          _buildAvatarCircle(context),
          const SizedBox(height: 10),
          const Text(
            'Mehdi Shop',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'mehdielouissi8@gmail.com',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 40,
            width: width * 0.25,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.maincolor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.bgColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Preferences',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: width,
              height: height * 0.42,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isLight
                      ? AppColors.fadeColor.withAlpha(150)
                      : AppColors.darkContainer,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      PreferencesRowItem(
                        title: 'Notifications',
                        trailingWidget: CupertinoSwitch(
                          thumbColor:
                              isLight ? AppColors.bgColor : Colors.grey[300],
                          activeColor: AppColors.maincolor,
                          value: notifcation,
                          onChanged: (value) {
                            setState(() {
                              notifcation = value;
                            });
                          },
                        ),
                        iconPath: AppVectors.bell,
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      const SizedBox(height: 5),
                      PreferencesRowItem(
                        title: 'Theme',
                        iconPath: AppVectors.theme,
                        trailingWidget: SizedBox(
                          height: 30,
                          width: width * 0.3,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: isLight
                                  ? AppColors.bgColor
                                  : AppColors.darkBgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                ),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5),
                                borderRadius: BorderRadius.circular(10),
                                value: 0,
                                items: const [
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text(
                                      'System',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      'Light',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text(
                                      'Dark',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      const SizedBox(height: 5),
                      const PreferencesRowItem(
                        title: 'Biometrics',
                        iconPath: AppVectors.biometrics,
                        trailingWidget: Text(
                          'COMING SOON',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      const SizedBox(height: 5),
                      PreferencesRowItem(
                        title: 'About',
                        iconPath: AppVectors.profile,
                        trailingWidget: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.keyboard_arrow_right_rounded,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<DrawerItemCubit>(context)
                              .changeIndex(4);
                        },
                        child: PreferencesRowItem(
                          title: 'Support',
                          iconPath: AppVectors.support,
                          trailingWidget: GestureDetector(
                            child: const Icon(
                              Icons.keyboard_arrow_right_rounded,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () async {
                          final result = await confirmationDialog(
                            context,
                            title: 'Logout',
                            content: 'Are you sure you want to logout ?',
                          );

                          if (result == true) {
                            context.read<ShopBloc>().add(LogoutFromShop());
                            context.navigator
                                .pushReplacementNamed(AppRouter.loginPage);
                          }
                        },
                        child: PreferencesRowItem(
                          title: 'Logout',
                          iconPath: AppVectors.logout,
                          trailingWidget: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.keyboard_arrow_right_rounded,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'All rights preserved to QUANTIFY.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          )
        ],
      ),
    ));
  }

  SizedBox _buildAvatarCircle(BuildContext context) {
    final isLight = context.brightness == Brightness.light;
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isLight
                  ? AppColors.maincolor.withOpacity(0.4)
                  : AppColors.bgColor.withOpacity(0.4),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppVectors.user,
                height: 50,
                width: 50,
                colorFilter: isLight
                    ? const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.colorBurn,
                      )
                    : ColorFilter.mode(
                        AppColors.bgColor.withAlpha(160),
                        BlendMode.srcIn,
                      ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 0,
            child: SizedBox(
              height: 30,
              width: 30,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(1, 1),
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SvgPicture.asset(
                    AppVectors.pencil,
                    colorFilter: const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PreferencesRowItem extends StatelessWidget {
  const PreferencesRowItem(
      {super.key,
      required this.title,
      required this.trailingWidget,
      required this.iconPath});
  final String iconPath;
  final String title;
  final Widget trailingWidget;

  @override
  Widget build(BuildContext context) {
    final isLight = context.brightness == Brightness.light;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 35,
          width: 35,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isLight ? AppColors.bgColor : AppColors.darkBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    isLight ? AppColors.darkContainer : AppColors.bgColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        trailingWidget,
      ],
    );
  }
}
