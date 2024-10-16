import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quantify/core/configs/app_router.dart';

import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/dashboard/domain/entity/ticket.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_bloc.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_event.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:quantify/shared/widgets/dialogs.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_vectors.dart';

class ClientTicketCard extends StatefulWidget {
  const ClientTicketCard({
    super.key,
    required this.width,
    required this.isLight,
    required this.index,
    required this.ticket,
    this.inDoneView = false,
  });

  final double width;
  final bool isLight;
  final int index;
  final TicketEntity ticket;
  final bool? inDoneView;

  @override
  State<ClientTicketCard> createState() => _ClientTicketCardState();
}

class _ClientTicketCardState extends State<ClientTicketCard> {
  late SlideController _slideController;
  @override
  void initState() {
    _slideController = SlideController(
      usePostActionController: true,
      usePreActionController: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.brightness == Brightness.light;
    return GestureDetector(
      onLongPress: () async {
        if (widget.inDoneView == true) {
          final response = await confirmationDialog(
            context,
            title: 'Mark Undone',
            content: 'Are you sure you want to make this ticket undone ?',
          );
          if (response == true) {
            context.read<TicketsBloc>().add(
                  MarkUndoneTicket(
                    ticket: widget.ticket.copyWith(
                      isDone: false,
                    ),
                  ),
                );
            context
                .read<TicketsBloc>()
                .add(GetTicketsEvent(date: DateTime.now()));
          }
        }
      },
      child: SlidablePanel(
        controller: _slideController,
        maxSlideThreshold: 0.4,
        key: UniqueKey(),
        postActions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () async {
                await EasyLauncher.call(number: widget.ticket.clientPhone);
              },
              child: Container(
                height: 85,
                width: 55,
                decoration: BoxDecoration(
                  color: isLight
                      ? AppColors.maincolor.withOpacity(0.1)
                      : AppColors.darkCallContainer.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppVectors.call,
                    colorFilter: ColorFilter.mode(
                      isLight
                          ? AppColors.maincolor
                          : AppColors.darkCallContainer,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () async {
                final result = await confirmationDialog(
                  context,
                  title: 'Delete Ticket',
                  content: 'Are you sure you want to delete this ticket?',
                );
                if (result != null && result == true) {
                  context.read<TicketsBloc>().add(
                        DeleteTicketEvent(
                          id: widget.ticket.id!,
                        ),
                      );
                  context.read<TicketsBloc>().add(
                        GetTicketsEvent(
                          date: DateTime.now(),
                        ),
                      );
                }
              },
              child: Container(
                height: 85,
                width: 55,
                decoration: BoxDecoration(
                  color: isLight
                      ? AppColors.deleteColor.withOpacity(0.1)
                      : AppColors.deleteDarkColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppVectors.delete,
                    colorFilter: ColorFilter.mode(
                      isLight
                          ? AppColors.deleteColor
                          : AppColors.deleteDarkColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0, right: 2),
          child: Container(
            height: 85,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: isLight ? Colors.white : AppColors.darkContainer,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  offset: const Offset(0, 2),
                  color: Colors.black.withOpacity(0.25),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: widget.width * 0.122,
                  width: widget.width * 0.122,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.maincolor,
                  ),
                  child: Center(
                    child: Text(
                      "${widget.ticket.number}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ticket.clientName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Price: ',
                            style: TextStyle(
                              fontSize: 11.5,
                            ),
                          ),
                          Text(
                            '${widget.ticket.price} DA',
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
                const Spacer(),
                if (widget.inDoneView == false)
                  IconButton(
                    onPressed: () {
                      context.navigator.pushNamed(AppRouter.addEditTicketScreen,
                          arguments: widget.ticket);
                    },
                    icon: SvgPicture.asset(
                      AppVectors.pencilEdit,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
