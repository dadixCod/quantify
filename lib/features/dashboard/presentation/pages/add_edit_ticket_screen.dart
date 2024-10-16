import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quantify/core/configs/app_router.dart';
import 'package:quantify/core/constants/app_colors.dart';
import 'package:quantify/core/utils/context.dart';
import 'package:quantify/features/clients/domain/entity/client.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_bloc.dart';
import 'package:quantify/features/clients/presentation/blocs/clients_state.dart';
import 'package:quantify/features/dashboard/domain/entity/ticket.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_bloc.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_event.dart';
import 'package:quantify/features/dashboard/presentation/blocs/tickets_state.dart';
import 'package:quantify/shared/widgets/custom_filled_text_field.dart';
import 'package:quantify/shared/widgets/main_button.dart';

class AddEditTicketScreen extends StatefulWidget {
  final TicketEntity? selectedTicket;
  const AddEditTicketScreen({super.key, this.selectedTicket});

  @override
  State<AddEditTicketScreen> createState() => _AddEditTicketScreenState();
}

class _AddEditTicketScreenState extends State<AddEditTicketScreen> {
  late TextEditingController priceController;

  ClientEntity? selectedClient;
  int? selectedClientId;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? errorMessage;
  String? phoneText;

  @override
  void initState() {
    priceController = TextEditingController();
    if (widget.selectedTicket != null) {
      setState(() {
        selectedClientId = widget.selectedTicket!.clientId;
        phoneText = widget.selectedTicket!.clientPhone;
        priceController.text = widget.selectedTicket!.price.toString();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.brightness == Brightness.light;
    final height = context.deviceSize.height;
    final width = context.deviceSize.width;
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: isLight ? AppColors.mainText : Colors.white,
        title: Text(
          widget.selectedTicket != null ? 'Edit Ticket' : 'Add Ticket',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: BlocBuilder<ClientsBloc, ClientsState>(
            builder: (context, clientsState) {
          if (clientsState is ClientsLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(
                  isLight ? AppColors.maincolor : AppColors.bgColor,
                ),
              ),
            );
          }
          if (clientsState is ClientsError) {
            return Center(
              child: Text(clientsState.message),
            );
          }
          if (clientsState is ClientsLoaded) {
            final clients = clientsState.clients;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Client Name
                const Text('Client Name'),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      width: width * 0.75,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isLight
                            ? AppColors.lightCallContainer
                            : AppColors.darkContainer,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int?>(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                          value: selectedClientId,
                          items: [
                            const DropdownMenuItem(
                              value: null,
                              child: Text(
                                "Select Client",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            ...clients.map((client) {
                              return DropdownMenuItem(
                                value: client.id,
                                child: Text(client.name),
                              );
                            }),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedClientId = value;

                                selectedClient = clients
                                    .firstWhere((client) => client.id == value);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        context.navigator.pushNamed(AppRouter.addClientPage);
                      },
                      child: Container(
                        width: width * 0.15,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isLight
                              ? AppColors.lightCallContainer
                              : AppColors.darkContainer,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add_rounded,
                            color: isLight
                                ? AppColors.darkBgColor
                                : AppColors.bgColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                //Client Phone
                const Text('Client Phone'),
                const SizedBox(height: 15),
                Container(
                  width: width,
                  height: height * 0.06,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isLight
                        ? AppColors.lightCallContainer
                        : AppColors.darkContainer,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedClient == null
                          ? phoneText != null
                              ? phoneText!
                              : "Phone"
                          : selectedClient!.phone,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //Date
                const Text('Price'),
                const SizedBox(height: 15),
                CustomFilledTextField(
                  width: width,
                  height: height,
                  isLight: isLight,
                  controller: priceController,
                  hintText: 'Price',
                  inputType: TextInputType.number,
                  suffix: const Text('DA'),
                ),

                const SizedBox(height: 15),
                //Date
                const Text('Date'),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              selectedDate = value;
                            });
                          }
                        });
                      },
                      child: Container(
                        width: width * 0.4,
                        height: height * 0.06,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isLight
                              ? AppColors.lightCallContainer
                              : AppColors.darkContainer,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: isLight
                                  ? AppColors.darkBgColor
                                  : AppColors.bgColor,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                color: isLight
                                    ? AppColors.darkBgColor
                                    : AppColors.bgColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              selectedTime = value;
                            });
                          }
                        });
                      },
                      child: Container(
                        width: width * 0.4,
                        height: height * 0.06,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isLight
                              ? AppColors.lightCallContainer
                              : AppColors.darkContainer,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: isLight
                                  ? AppColors.darkBgColor
                                  : AppColors.bgColor,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              selectedTime.format(context),
                              style: TextStyle(
                                color: isLight
                                    ? AppColors.darkBgColor
                                    : AppColors.bgColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: TextStyle(
                      color: isLight
                          ? AppColors.deleteColor
                          : AppColors.deleteDarkColor,
                      fontSize: 14,
                    ),
                  ),
                const Spacer(),
                MainButton(
                  onTap: () {
                    if (selectedClientId == null ||
                        priceController.text.isEmpty ||
                        double.tryParse(priceController.text) == null) {
                      setState(() {
                        errorMessage = "Please select client and valid price";
                      });
                    } else {
                      setState(() {
                        errorMessage = null;
                      });
                      if (widget.selectedTicket != null) {
                        final updatedTicket = TicketEntity(
                          id: widget.selectedTicket!.id,
                          number: widget.selectedTicket!.number,
                          date: formattedDate,
                          time: selectedTime,
                          price: double.parse(priceController.text),
                          dept: 0,
                          clientId: selectedClientId!,
                          clientName: selectedClient?.name ??
                              widget.selectedTicket!.clientName,
                          clientPhone: selectedClient?.phone ?? phoneText!,
                        );

                        context
                            .read<TicketsBloc>()
                            .add(UpdateTicketEvent(ticket: updatedTicket));
                        context
                            .read<TicketsBloc>()
                            .add(GetTicketsEvent(date: DateTime.now()));

                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          context.navigator.pop();
                        });
                      } else {
                        final newTicket = TicketEntity(
                          date: formattedDate,
                          time: selectedTime,
                          price: double.parse(priceController.text),
                          dept: 0,
                          clientId: selectedClient!.id!,
                          clientName: selectedClient!.name,
                          clientPhone: selectedClient!.phone,
                        );
                        context
                            .read<TicketsBloc>()
                            .add(AddTicketEvent(ticket: newTicket));
                        context
                            .read<TicketsBloc>()
                            .add(GetTicketsEvent(date: DateTime.now()));

                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          context.navigator.pop();
                        });
                      }
                    }
                  },
                  child: BlocBuilder<TicketsBloc, TicketsState>(
                      builder: (context, state) {
                    if (state is TicketActionLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation(AppColors.bgColor),
                        ),
                      );
                    }
                    return Text(
                      widget.selectedTicket == null
                          ? 'Add Ticket'
                          : 'Edit Ticket',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    );
                  }),
                )
              ],
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
