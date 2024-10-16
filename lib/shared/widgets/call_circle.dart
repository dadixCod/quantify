
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';

class CallCircle extends StatelessWidget {
  const CallCircle({
    super.key,
    required this.isLight,
  });

  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isLight
            ? AppColors.maincolor.withOpacity(0.3)
            : AppColors.darkCallContainer.withOpacity(0.5),
      ),
      child: Center(
        child: SvgPicture.asset(
          AppVectors.call,
          colorFilter: ColorFilter.mode(
            isLight ? AppColors.maincolor : AppColors.darkCallContainer,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
