import 'package:flutter/material.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/utils/context.dart';

Future<bool?> confirmationDialog(BuildContext context,
    {required String title, required String content, bool? positif}) {
  final isLight = context.brightness == Brightness.light;
  return showGeneralDialog<bool>(
    context: context,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero);
      var transition = tween
          .animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

      return SlideTransition(
        position: transition,
        child: child,
      );
    },
    pageBuilder: (context, animation, secondAnimation) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              context.navigator
                  .pop(positif != null && positif == true ? false : true);
            },
            child: Text(
              positif != null && positif == true ? 'Non' : 'Oui',
              style: TextStyle(
                color: positif != null && positif == true
                    ? isLight
                        ? AppColors.mainText
                        : AppColors.bgColor
                    : AppColors.deleteColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.navigator
                  .pop(positif != null && positif == true ? true : false);
            },
            child: Text(
              positif != null && positif == true ? 'Oui' : 'Non',
            ),
          ),
        ],
      );
    },
  );
}
