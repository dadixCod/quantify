import 'package:flutter/material.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/utils/context.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.onChanged,
      this.width,
      required this.hint,
       this.icon,
      required this.controller,
      this.keyboardType});
  final Function(String)? onChanged;
  final double? width;
  final String hint;
  final Widget? icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: context.brightness == Brightness.light
              ? AppColors.borderColor
              : AppColors.borderDarkColor,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          icon: icon,
          contentPadding: const EdgeInsets.only(
            bottom: 10,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
