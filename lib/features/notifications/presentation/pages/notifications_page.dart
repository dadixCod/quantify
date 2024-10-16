import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';
import 'package:quantify/core/utils/context.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.deviceSize.width;
    final height = context.deviceSize.height;
    final isLight = context.brightness == Brightness.light;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor:
              isLight ? AppColors.darkContainer : AppColors.bgColor,
          leading: IconButton(
            onPressed: () {
              context.navigator.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                isLight
                    ? AppVectors.notifications
                    : AppVectors.notificationsDark,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: width / 2,
                child: Text(
                  "You don't have any notifications yet !",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
