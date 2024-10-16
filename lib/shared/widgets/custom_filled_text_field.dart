import 'package:flutter/material.dart';
import 'package:quantify/core/constants/app_colors.dart';

class CustomFilledTextField extends StatelessWidget {
  const CustomFilledTextField({
    super.key,
    required this.width,
    required this.height,
    required this.isLight,
    required this.controller,
    this.hintText,
    this.inputType,
    this.suffix,
    this.enabled = true,
  });

  final double width;
  final double height;
  final bool isLight;
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffix;
  final TextInputType? inputType;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.06,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isLight ? AppColors.lightCallContainer : AppColors.darkContainer,
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: InputBorder.none,
          suffix: suffix,
        ),
        keyboardType: inputType,
      ),
    );
  }
}
