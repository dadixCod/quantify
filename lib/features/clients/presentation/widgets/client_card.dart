import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quantify/core/configs/app_router.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/constants/app_vectors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_bloc.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_event.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_bloc.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_event.dart';
import 'package:quantify/shared/widgets/dialogs.dart';

class ClientCard extends StatefulWidget {
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
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  late SlideController slideController;
  @override
  void initState() {
    slideController = SlideController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.brightness == Brightness.light;
    return SlidablePanel(
      controller: slideController,
      key: UniqueKey(),
      maxSlideThreshold: 0.4,
      postActions: [
        GestureDetector(
          onTap: () async {
            await EasyLauncher.call(
              number: widget.client.phone,
            );
          },
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 2.5,
                right: 2.5,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isLight
                      ? AppColors.maincolor.withOpacity(0.3)
                      : AppColors.darkCallContainer.withOpacity(0.3),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppVectors.call,
                    colorFilter: ColorFilter.mode(
                        isLight
                            ? AppColors.maincolor
                            : AppColors.darkCallContainer,
                        BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            final response = await confirmationDialog(
              context,
              title: 'Delete Client',
              content: 'Are you sure you want to delete this client ? ',
            );
            if (response == true) {
              BlocProvider.of<ClientsBloc>(context).add(
                DeleteClientEvent(
                  id: widget.client.id!,
                ),
              );
              context.read<ClientsBloc>().add(GetClientsEvent());
              context
                  .read<TicketsBloc>()
                  .add(GetTicketsEvent(date: DateTime.now()));
            }
          },
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isLight
                      ? AppColors.deleteColor.withOpacity(0.3)
                      : AppColors.deleteDarkColor.withOpacity(0.3),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppVectors.delete,
                    colorFilter: ColorFilter.mode(
                        isLight
                            ? AppColors.deleteColor
                            : AppColors.deleteDarkColor,
                        BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
      child: SizedBox(
        height: widget.height * 0.175,
        child: Card(
          color: widget.isLight ? Colors.white : AppColors.darkContainer,
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
                      widget.client.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.navigator.pushNamed(
                              AppRouter.addEditClientPage,
                              arguments: widget.client,
                            );
                          },
                          child: SvgPicture.asset(
                            AppVectors.pencil,
                            colorFilter: ColorFilter.mode(
                              widget.isLight
                                  ? AppColors.darkBgColor
                                  : AppColors.borderDarkColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
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
                            color: widget.isLight
                                ? AppColors.mainText.withOpacity(0.5)
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.client.visits.toString(),
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
                            color: widget.isLight
                                ? AppColors.mainText.withOpacity(0.5)
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${widget.client.dept} DA',
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
                            color: widget.isLight
                                ? AppColors.mainText.withOpacity(0.5)
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${widget.client.totalSpent} DA',
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
      ),
    );
  }
}
