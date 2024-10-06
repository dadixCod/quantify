import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/features/dashboard/domain/entity/ticket.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_bloc.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_event.dart';

import '../../../../core/constants/app_vectors.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    super.key,
    required this.height,
    required this.isLight,
    required this.width,
    required this.ticket,
  });

  final double height;
  final bool isLight;
  final double width;
  final TicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.225,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isLight ? Colors.white : AppColors.darkContainer,
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 2),
            blurRadius: 13,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.11),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Current Client',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'More info',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    color:
                        isLight ? AppColors.maincolor : AppColors.tertiaryText,
                  ),
                ),
              )
            ],
          ),
          // const SizedBox(height: 8),
          Divider(
            height: 1,
            color: isLight ? AppColors.tertiaryText : AppColors.hintColor,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.clientName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 24,
                    width: 100,
                    decoration: BoxDecoration(
                      color: isLight
                          ? AppColors.maincolor.withOpacity(0.16)
                          : Colors.white.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Price: ',
                          style: TextStyle(
                            fontSize: 11.5,
                          ),
                        ),
                        Text(
                          '${ticket.price} DA',
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: width * 0.122,
                width: width * 0.122,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.maincolor,
                ),
                child: Center(
                  child: Text(
                    ticket.number.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),

          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isLight
                        ? AppColors.deleteColor
                        : AppColors.deleteDarkColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<TicketsBloc>().add(
                        UpdateTicketEvent(
                          ticket: ticket.copyWith(isDone: true),
                        ),
                      );
                  context
                      .read<TicketsBloc>()
                      .add(GetTicketsEvent(date: DateTime.now()));
                },
                splashColor: Colors.white.withOpacity(0.4),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 28,
                  width: 109,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.maincolor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mark done',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SvgPicture.asset(
                        AppVectors.check,
                        height: 10,
                        width: 10,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
