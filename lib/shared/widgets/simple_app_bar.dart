import 'package:flutter/material.dart';
import 'package:quantify/core/constants/app_colors.dart';

class SimpleAppBar extends StatelessWidget {
  const SimpleAppBar({
    super.key,
    required this.height,
    required this.width,
    this.trailing,
    required this.title,
  });

  final double height;
  final double width;
  final Widget? trailing;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.11,
      width: width,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.maincolor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                  width: 50,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bgColor,
                  ),
                ),
                if (trailing != null) trailing!
              ]),
        ),
      ),
    );
  }
}
