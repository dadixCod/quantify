import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quantify/core/configs/app_router.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/dashboard/domain/entity/ticket.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_bloc.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_event.dart';
import 'package:quantify/shared/widgets/call_circle.dart';
import 'package:quantify/shared/widgets/custom_filled_text_field.dart';
import 'package:quantify/shared/widgets/dialogs.dart';

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
          const SizedBox(height: 8),
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
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await EasyLauncher.call(number: ticket.clientPhone);
                    },
                    child: CallCircle(
                      isLight: isLight,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      context.navigator.pushNamed(
                        AppRouter.addEditTicketScreen,
                        arguments: ticket,
                      );
                    },
                    child: SvgPicture.asset(
                      AppVectors.pencil,
                      colorFilter: ColorFilter.mode(
                        isLight ? AppColors.darkBgColor : AppColors.bgColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: isLight
                          ? AppColors.maincolor.withOpacity(0.16)
                          : Colors.white.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                onTap: () async {
                  final response = await confirmationDialog(
                    context,
                    title: 'Delete Ticket',
                    content: 'Are you sure you want to delete this ticket',
                  );
                  if (response == true) {
                    context
                        .read<TicketsBloc>()
                        .add(DeleteTicketEvent(id: ticket.id!));

                    context
                        .read<TicketsBloc>()
                        .add(GetTicketsEvent(date: DateTime.now()));
                  }
                },
                child: Text(
                  'Delete',
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
                onTap: () async {
                  await showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: 'dept dialog',
                    transitionBuilder:
                        (context, animation, secondAnimation, child) {
                      var tween = Tween<Offset>(
                          begin: const Offset(0, -1), end: Offset.zero);
                      var transition = tween.animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.fastOutSlowIn,
                        ),
                      );
                      return SlideTransition(
                        position: transition,
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, __) {
                      return Center(
                        child: Container(
                          height: height / 2,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isLight
                                ? AppColors.bgColor
                                : AppColors.darkBgColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DeptContainer(
                            width: width,
                            height: height,
                            isLight: isLight,
                            ticket: ticket,
                          ),
                        ),
                      );
                    },
                  );
                  context
                      .read<TicketsBloc>()
                      .add(GetTicketsEvent(date: DateTime.now()));
                },
                child: Text(
                  'In Dept',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isLight
                        ? AppColors.maincolor
                        : AppColors.darkCallContainer,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final response = await confirmationDialog(
                    context,
                    title: 'Mark Ticket done',
                    content: 'Are you sure this client is done and payed ? ',
                    positif: true,
                  );
                  if (response == true) {
                    context.read<TicketsBloc>().add(
                          MarkDoneTicketEvent(
                            ticket: ticket.copyWith(isDone: true),
                          ),
                        );
                    context
                        .read<TicketsBloc>()
                        .add(GetTicketsEvent(date: DateTime.now()));
                  }
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

class DeptContainer extends StatefulWidget {
  const DeptContainer({
    super.key,
    required this.width,
    required this.height,
    required this.isLight,
    required this.ticket,
  });

  final double width;
  final double height;
  final bool isLight;
  final TicketEntity ticket;

  @override
  State<DeptContainer> createState() => _DeptContainerState();
}

class _DeptContainerState extends State<DeptContainer> {
  late TextEditingController ticketController;
  late TextEditingController deptController;
  @override
  void initState() {
    ticketController = TextEditingController();
    deptController = TextEditingController();
    ticketController.text = widget.ticket.price.toString();
    deptController.text = '0.0';
    super.initState();
  }

  @override
  void dispose() {
    deptController.dispose();
    super.dispose();
  }

  bool wrongInput = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Client In Dept',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Ticket Amount',
            ),
            const SizedBox(height: 10),
            CustomFilledTextField(
              width: widget.width,
              height: widget.height,
              isLight: widget.isLight,
              controller: ticketController,
              hintText: '0.0',
              suffix: const Text('DA'),
              enabled: false,
            ),
            const SizedBox(height: 30),
            const Text(
              'Payed Amount',
            ),
            const SizedBox(height: 10),
            CustomFilledTextField(
              width: widget.width,
              height: widget.height,
              isLight: widget.isLight,
              controller: deptController,
              suffix: const Text('DA'),
              inputType: TextInputType.number,
              hintText: '0.0',
            ),
            const SizedBox(height: 10),
            if (wrongInput)
              Text(
                'Payed amount should be equal or smaller than ticket amount',
                style: TextStyle(
                  color: widget.isLight
                      ? AppColors.deleteColor
                      : AppColors.deleteDarkColor,
                  fontSize: 12,
                ),
              ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    context.navigator.pop(false);
                  },
                  child: const Text(
                    'Cancel',
                  ),
                ),
                InkWell(
                  splashColor: AppColors.maincolor.withOpacity(0.3),
                  onTap: () {
                    if (deptController.text.isNotEmpty &&
                        double.tryParse(deptController.text) != null &&
                        double.parse(deptController.text) <=
                            double.parse(ticketController.text)) {
                      setState(() {
                        wrongInput = false;
                      });
                      context.read<TicketsBloc>().add(
                            MarkClientDept(
                              ticket: widget.ticket.copyWith(
                                isDone: true,
                                dept: widget.ticket.price -
                                    double.parse(deptController.text),
                              ),
                            ),
                          );
                      context.navigator.pop(true);
                    } else {
                      setState(() {
                        wrongInput = true;
                      });
                    }
                  },
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.maincolor,
                    ),
                    child: const Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bgColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
