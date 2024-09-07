import 'package:flutter/material.dart';
import 'package:quantify/core/constants/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: AppColors.maincolor,
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.bgColor.withOpacity(0.3),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
