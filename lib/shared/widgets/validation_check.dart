import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';
import 'package:quantify/core/utils/context.dart';

class ValidationCheck extends StatelessWidget {
  const ValidationCheck({
    super.key,
    required this.isChecked,
    required this.text,
  });

  final bool isChecked;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 18,
          width: 18,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isChecked
                ? AppColors.successColor
                : context.brightness == Brightness.light
                    ? AppColors.fadeColor
                    : AppColors.hintColor,
          ),
          child: isChecked
              ? SvgPicture.asset(
                  AppVectors.check,
                )
              : const SizedBox(),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: context.theme.hintColor,
          ),
        )
      ],
    );
  }
}
