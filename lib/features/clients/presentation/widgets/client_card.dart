import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/shared/widgets/call_circle.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({
    super.key,
    required this.height,
    required this.isLight,
    required this.client,
  });

  final double height;
  final bool isLight;
  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.175,
      child: Card(
        color: isLight ? Colors.white : AppColors.darkContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    client.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await EasyLauncher.call(number: client.phone);
                    },
                    child: CallCircle(
                      isLight: isLight,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Visits',
                        style: TextStyle(
                          color: isLight
                              ? AppColors.mainText.withOpacity(0.5)
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        client.visits.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Dept',
                        style: TextStyle(
                          color: isLight
                              ? AppColors.mainText.withOpacity(0.5)
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${client.dept} DA',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Spent',
                        style: TextStyle(
                          color: isLight
                              ? AppColors.mainText.withOpacity(0.5)
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${client.totalSpent} DA',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
