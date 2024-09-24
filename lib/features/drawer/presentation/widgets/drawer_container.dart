import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerContainer extends StatelessWidget {
  const DrawerContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
  });
  final String title;
  final String icon;
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
              SvgPicture.asset(icon),
              const SizedBox(width: 20),
              Text(
                title,
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
